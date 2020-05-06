$TxtFile = Get-Content -Path ".\text.txt"

#regular expresion & counter of lines
$regExp = "\.google.com|\.google.cz"
$linesCounter = 0

foreach($line in $TxtFile)
{
    $linesCounter++
    if($line -notmatch $regExp)
    {
    Add-Content -path ".\text_new.txt" -Value $line
    $linesCounter--
    }
}
Write-Host "Bylo nalezeno: $linesCounter výrazů"

#comparison used files
compare-object (get-content .\text.txt) (get-content .\text_new.txt)
