Function Invoke-ProcessWatch {
<#
.SYNOPSIS

    Invoke-ProcessWatch

	Updated by MNSU ISSO Team
    Original Author: Chris Campbell (@obscuresec)
    License: BSD 3-Clause

.DESCRIPTION

    A script that can be used to prevent the starting of any new processes
    
.EXAMPLE

    PS C:\> Invoke-ProcessWatch -Delay 10
   
.LINK

	Original author links below
    https://github.com/obscuresec/CCDC/blob/master/Invoke-ProcessLock
    http://obscuresec.com/

.REMARK

    This script was created for CTF competitions like CCDC, don't use in production.

#>

[CmdletBinding()] Param(
        [Parameter()] [int32] $Delay = '5'
        )


    #Get allowed processes
    $LockedPS = Get-Process

        #Create function to compare against allowed processes
        Function CompareFunction {
            #Get updated process list
            $UpdatePS = Get-Process
            #Compare the listes
            $CompareObject = (Compare-Object -property name, id $LockedPS $UpdatePS)

            #Look for new processes
            foreach ($Object in $CompareObject) {
                if ($Object.SideIndicator -eq '=>') {
					$ProcessID = $Object.ID
					$ProcessName = $Object.name
                    Write-Verbose "$(Get-Date -format "yyyy/MM/dd hh:mm:ss") new process: $ProcessName, ID: $ProcessID"
                    Write-Verbose "Stopping $ProcessName $ProcessID"
                    Stop-Process -ID $ProcessID
                    }
            }
            #Sleep for the specified number of seconds
            Start-Sleep -seconds $Delay

        }
    #Loop forever so only ctrl-c will stop the function
    for (;;) {
            CompareFunction
        }
}
Invoke-ProcessWatch -Verbose
