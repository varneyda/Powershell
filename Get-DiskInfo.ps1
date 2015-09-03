<#
.Synopsis
   Retrieve basic info about permanent disks in the specified system.
.DESCRIPTION
   Retrieve basic info about permanent disks in the specified system. Returns the Drive Letter, Type, Volume Name, Size, and Freespace of all drives.
.EXAMPLE
   Get-DiskInfo -Computername $env:COMPUTERNAME
.EXAMPLE
   Get-DiskInfo -ComputerName Computer1,Computer2,Computer3
#>
function Get-DiskInfo{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)]
        [String[]]$ComputerName,
        [Parameter (Mandatory=$false,Position=1)]
        [System.Management.Automation.PSCredential]$Credential
    )
    begin{
        $disk=$null
        $out=$null
    }
    process{
        if($Credential -eq $null){
            $Disk= Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName $ComputerName| where {$_.DriveType -eq 3} | 
            select SystemName, VolumeName, Name,
            @{n='Size (GB)';e={"{0:0}" -f ($_.size/1gb)}},
            @{n='FreeSpace (GB)';e={"{0:0}" -f ($_.freespace/1gb)}},
            @{n='PrecentFree';e={"{0:0}" -f ($_.freespace/$_.size*100)}}
            $out= $Disk | ft -AutoSize
        }#end if
        else{
            $session= New-CimSession -ComputerName $ComputerName -Credential $Credential
            $Disk= Get-CimInstance -ClassName Win32_LogicalDisk -CimSession $session| where {$_.DriveType -eq 3} | 
            select SystemName, VolumeName, Name,
            @{n='Size (GB)';e={"{0:0}" -f ($_.size/1gb)}},
            @{n='FreeSpace (GB)';e={"{0:0}" -f ($_.freespace/1gb)}},
            @{n='PrecentFree';e={"{0:0}" -f ($_.freespace/$_.size*100)}}
            $out= $Disk | ft -AutoSize
        }#end else
    }
    end{
        return $out
        Get-CimSession | Remove-CimSession
    }
}#end Get-DiskInfo 
