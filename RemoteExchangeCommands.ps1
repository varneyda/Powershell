#Example of using implicit remoting to use the EMS commands
$session= New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "http://exchange.example.local/powershell" `
-Credential example\administrator
Import-PSSession $session
