Import-Module ActiveDirectory
Write-Host "Nástroj na vytvoření skupin v ActiveDirectory."
Write-Host "----------------------------------------------------------------------------------"
Write-Host "Zdrojový soubor musí být CSV soubor, který splňuje následující podmínky:"
Write-Host "- Buňka A1 můsí začínat názvem 'skupiny'"
Write-Host "- A2-Ax názvy skupin"
Write-Host ""
$csvFile = Read-Host -Prompt "Zadejte cestu k CSV souboru např.(C:\TEMP\moje.csv) "
$rolePicker = Read-Host -Prompt "Vyberte číslem, kam groupy přidat: `n1.Business Role`n2.Application Role`n3.Resource Group`n"

# choose path to desired container
if($rolePicker -eq "1")
{
$rolePicked = "path to desired container"
}
elseIf($rolePicker -eq "2")
{
$rolePicked = "path to desired container"
}
elseIf($rolePicker -eq "3")
{
$rolePicked = "path to desired container"
}


$table = Import-Csv $csvFile 

#neccessary if need to be authorized with elevated account
$lsaAccount="Account"
$cred = Get-Credential $lsaAccount

foreach ($item in $table)
{
    $itemString = $item.("skupiny")
    #write-host $rolePicked
    New-ADGroup -Credential $cred -Name $itemString -SamAccountName $itemString -GroupCategory Security -GroupScope Global -Path $rolePicked
    Write-Host "Skupina vytvořena: $itemString"
}
