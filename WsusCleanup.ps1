<#
If you manually approve updates after testing for compatability this will save time cleaining up outdated or superceded updates from the server.
#>
$session = New-PSSession -Computername Sus.example.local -Credential $cred
icm -Session $session {Get-WsusServer | Invoke-WsusServerCleanup -DeclineExpiredUpdates -DeclineSupderseededUpdates -verbose}
icm -Session $session {Get-WsusServer | Invoke-WsusServerCleanup -CleanupObsoleteUpdates -verbose}
icm -Session $session {Get-WsusServer | Invoke-WsusServerCleanup -CleanupUnneededContentFiles -verbose}
Get-PSSession | Remove-PSSession
