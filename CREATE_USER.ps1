﻿# ----- Edit these Variables for your own Use Case ----- #
$PASSWORD_FOR_USERS   = "Password1"
$USER_FIRST_LAST_LIST = Get-Content C:\Users\a-cmarshall\Desktop\AD_PS-master\names.txt
# ------------------------------------------------------ #

$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force
New-ADOrganizationalUnit -Name _USERS -ProtectedFromAccidentalDeletion $false


    $first = ($USER_FIRST_LAST_LIST | Get-Random -count 1).Split(" ")[0].ToLower()
    $last  = ($USER_FIRST_LAST_LIST | Get-Random -count 1).Split(" ")[1].ToLower()
    $username = "$($first.Substring(0,1))$($last)".ToLower()
    Write-Host "Creating user: $($username)" -BackgroundColor Black -ForegroundColor Cyan
    
      $NewUserSPlat = @{
        AccountPassword = $password
        GivenName = $first
        Surname = $last
        DisplayName = $username
        Name = $username
        EmployeeID = $username
        PasswordNeverExpires = $true
        Path = "ou=_USERS,$(([ADSI]`"").distinguishedName)"
        Enabled = $true
        }
    New-AdUser @NewUserSPlat