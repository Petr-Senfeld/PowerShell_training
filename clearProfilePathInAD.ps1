$lsaAccount="account"
$cred = Get-Credential $lsaAccount

$users = Get-ADUser -Filter * -Properties * -SearchBase "OU,DC" | select name

foreach ($corpkey in $users) 
{
    Set-ADUser -Identity $corpkey -Clear ProfilePath
}
