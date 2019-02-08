dism /online /disable-feature /featurename:Printing-Server-Role
dism /online /disable-feature /featurename:DHCPServer
dism /online /disable-feature /featurename:IIS-WebServer
dism /online /disable-feature /featurename:IIS-FTPServer
dism /online /disable-feature /featurename:IIS-WebServerRole
dism /online /disable-feature /featurename:IIS-WebServerManagementTools
dism /online /disable-feature /featurename:IIS-ManagementScriptingTools
dism /online /disable-feature /featurename:IIS-IIS6ManagementCompatibility
dism /online /disable-feature /featurename:IIS-Metabase
dism /online /disable-feature /featurename:IIS-ManagementConsole
dism /online /disable-feature /featurename:DNS-Server-Full-Role
dism /online /disable-feature /featurename:Microsoft-Windows-GroupPolicy-ServerAdminTools-Update

net user IWAM_SHAREPEG /del
net user IUSR_SHAREPEG /del
net user HVU_FILESERVER1 /del

Import-Module ActiveDirectory

Remove-ADComputer -Identity XP-WS
Remove-ADComputer -Identity e-commerce
Remove-ADComputer -Identity ubuntu-ws