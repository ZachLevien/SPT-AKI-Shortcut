Function Get-Folder()
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }

    # Checking if path was selected
    if([string]::IsNullOrEmpty($folder) -eq $true){
        $try_again = Read-Host -Prompt "No SPT install path chose, whould you like to try again? (y) or (n)"
        
        if($try_again -eq "y"){
            return Get-Folder
        }else{
            # Closing script if nothing is chosen.
            exit
        }
    }

    return $folder
}

$install_path = Get-Folder

$desktop = [Environment]::GetFolderPath([Environment+SpecialFolder]::Desktop)

Write-Output "Copying files"
Copy-Item start_aki.ps1 $install_path

$ShortcutPath = "${desktop}\Start-SPT-Aki.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = "c:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
$shortcut.Arguments = "-ExecutionPolicy Bypass -File `"${install_path}\start_aki.ps1`""
$shortcut.IconLocation = "${install_path}\Aki_Data\Server\images\icon.ico"
$shortcut.WorkingDirectory = "$install_path"
$shortcut.Save()

Write-Output "Done :)"