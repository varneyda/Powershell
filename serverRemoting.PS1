<# Simple script to get a list of servers and make it easy to remote into them. This assumes they have already been setup to allow pssessions.

list.txt should simply be a text file with all your servers' host names on a new line
#>

#Get current user path for list.txt
$currentuser= $env:USERPROFILE
$list= Get-Content -Path $currentuser\documents\list.txt

#set your credential for remoting (can also use $env:USERNAME)
$credential = "mydomain\user"

Write-Host Choose Which server you wish to remote to:
Write-Host $list -Separator `n
$server= Read-Host -Prompt "Please enter your selection"
switch($server){
  $list[0]{start powershell | Enter-PSSession -ComputerName $list[0] -Credential $credential}
  $list[1]{start powershell | Enter-PSSession -ComputerName $list[1] -Credential $credential}
  $list[2]{start powershell | Enter-PSSession -ComputerName $lsit[2] -Credential $credential}
default{Write-Host "Please select a valid host."}
} #end switch
