# path to folders
$foldersPath = Get-ChildItem -Directory -Path "path" -Force

$output = @()

ForEach ($folder in $folderPath) {

    # pretty much the security tab in Properties of the folder
    $acl = Get-Acl -Path $folder.FullName
    
    # definiton of output for every folder
    ForEach ($access in $acl.Access) 
    {
    $properties = [ordered]@{'Folder Name'=$folder.FullName;'Group/User'=$access.IdentityReference;'Permissions'=$access.FileSystemRights}
    $output += New-Object -TypeName PSObject -Property $properties            
    }
}
$output | Export-Csv "C:\PRACDOCH\folders.csv"
