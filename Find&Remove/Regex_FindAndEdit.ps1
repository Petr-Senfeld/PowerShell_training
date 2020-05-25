##
## promenne zacatek
##

$txtFilePath = ".\hosts.txt"
$newTxtFilePath = ".\text_new.txt"
$approvedWebSites = Import-Csv -Delimiter ";" -Path ".\ApprovedWebSites.csv" 
$additionalWebSites = Import-Csv -Delimiter ";" -Path ".\AdditionalBlockedWebSites.csv" 
$switch = 1 # hodnota 0 (spusti pouze $approvedWebSites) nebo hodnota 1 (spusti approvedWebSites a additionalWebSites soubezne)

##
## promenne konec
##

$txtFile = Get-Content -Path $txtFilePath
$linesCounter = 0
$linesEdited = 0
$date = Get-Date -format "HH:mm:ss"
$skipper = 1

foreach($line in $txtFile)
{
    # spousti se $additionalWebSites & $approvedWebSites  pokud $switcher = 1
    if($switch -eq 1)
    {
        # cyklus, ktery projde sloupec Domain v nactenem CSV souboru a porovnava ho jako regEx s každým řádkem
        foreach($item in $approvedWebSites) 
        {
            if($line -match $item.Domain)
            {
                $lineTwo = ("`# " + $item.Comment + " `# " + "Schvalil: " + $item.ApprovedBy + " `# " + "Datum: " + $date +" `# "+ $line)
                Add-Content -path $newTxtFilePath -Value $lineTwo
                $linesCounter++
                $linesEdited++
                $skipper = 2
            }        
        }
        # cyklus, ktery projde sloupec Domain v nactenem CSV souboru a porovnava ho jako regEx s každým řádkem
        foreach($additionalLine in $additionalWebSites)
        {
            if($line -match $additionalLine.Domain)
            {
                $lineThree = ($line + " `# " + $additionalLine.Comment + " `# " + "Schvalil: " + $additionalLine.ApprovedBy + " `# " + "Datum: " + $date +" `# ")
                Add-Content -path $newTxtFilePath -Value $lineThree
                $linesCounter++
                $linesEdited++
                $skipper = 2
            } 
        }
    }
    # spousti se pouze $approvedWebSites pokud $switcher = 0
    else
    {
        # cyklus, ktery projde sloupec Domain v nactenem CSV souboru a porovnava ho jako regEx s každým řádkem
        foreach($item in $approvedWebSites) 
        {
            if($line -match $item.Domain)
            {
                $lineTwo = ("`# " + $item.Comment + " `# " + "Schvalil: " + $item.ApprovedBy + " `# " + "Datum: " + $date +" `# "+ $line)
                Add-Content -path $newTxtFilePath -Value $lineTwo
                $linesCounter++
                $linesEdited++
                $skipper = 2
            }        
        }
    }
    # pokud byl jiz radek upraven $skipper ho preskoci
    if($skipper -eq 1)
    {
        Add-Content -path $newTxtFilePath -Value $line
        $linesCounter++
    }
    elseif($skipper -eq 2)
    {
        $skipper = 1
    }
}

Write-Host "Celkem přečteno: $linesCounter řádků"
Write-Host "Celkem upraveno: $linesEdited řádků"
