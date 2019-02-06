function Watch-ProcessesUsers {
	# watches for new user logins and new processes
	# written by MNSU CCDC team
	# some code based on code written by Chris Campbell (@obscuresec)
    # License: BSD 3-Clause
	
	function get-loggedonuser ($computername = $env:computername){

		#mjolinor 3/17/10

		$regexa = '.+Domain="(.+)",Name="(.+)"$'
		$regexd = '.+LogonId="(\d+)"$'

		$logontype = @{
		"0"="Local System"
		"2"="Interactive" #(Local logon)
		"3"="Network" # (Remote logon)
		"4"="Batch" # (Scheduled task)
		"5"="Service" # (Service account logon)
		"7"="Unlock" #(Screen saver)
		"8"="NetworkCleartext" # (Cleartext network logon)
		"9"="NewCredentials" #(RunAs using alternate credentials)
		"10"="RemoteInteractive" #(RDP\TS\RemoteAssistance)
		"11"="CachedInteractive" #(Local w\cached credentials)
		}

		$logon_sessions = @(gwmi win32_logonsession -ComputerName $computername)
		$logon_users = @(gwmi win32_loggedonuser -ComputerName $computername)

		$session_user = @{}

		$logon_users |% {
		$_.antecedent -match $regexa > $nul
		$username = $matches[1] + "\" + $matches[2]
		$_.dependent -match $regexd > $nul
		$session = $matches[1]
		$session_user[$session] += $username
		}


		$logon_sessions |%{
			$starttime = [management.managementdatetimeconverter]::todatetime($_.starttime)

			$loggedonuser = New-Object -TypeName psobject
			$loggedonuser | Add-Member -MemberType NoteProperty -Name "Session" -Value $_.logonid
			$loggedonuser | Add-Member -MemberType NoteProperty -Name "User" -Value $session_user[$_.logonid]
			$loggedonuser | Add-Member -MemberType NoteProperty -Name "Type" -Value $logontype[$_.logontype.tostring()]
			$loggedonuser | Add-Member -MemberType NoteProperty -Name "Auth" -Value $_.authenticationpackage
			$loggedonuser | Add-Member -MemberType NoteProperty -Name "StartTime" -Value $starttime

			$loggedonuser
			}
	}
	
	# one-time setup
	$log = "c:\users\$env:username\documents\Watch-ProcessesUsers.log"
	$previousUsers = get-loggedonuser
	$newUsers = 0
	$PreviousPS = Get-Process
	$UpdatePS = 0
	
	for (;;) {
		$timestamp=Get-Date -format "yyyy/MM/dd HH:mm:ss"
		
		# get user data
		$newUsers = get-loggedonuser
		$CompareUsers= (Compare-Object $previousUsers.session $newUsers.session)
		
		foreach ($Object in $CompareUsers) {
			if ($Object.SideIndicator -eq '=>') {
				$out = "$timestamp New User: $($Object.user), Session: $($Object.session), Type: $($Object.type), Auth: $($Object.auth)"
				write-output $out
				add-content $log -value $out 
			}
		}
		$previousUsers = $newUsers
		
		# get process data
		$UpdatePS = Get-Process
		$CompareObject = (Compare-Object -property name, id $PreviousPS $UpdatePS)
		
		foreach ($Object in $CompareObject) {
			if ($Object.SideIndicator -eq '=>') {
				$ProcessID = $Object.ID
				$ProcessName = $Object.name
				$out = "$timestamp New Process: $ProcessName, ID: $ProcessID"
				Write-Output $out
				Add-content $log -value $out 
			}
		}
		$PreviousPS = $UpdatePS
		
		Start-Sleep -seconds 5
	}
}
Watch-ProcessesUsers
