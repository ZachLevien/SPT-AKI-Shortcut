function Launch-If-Closed {
    param (
        $ProcessName
    )

    $IsRunning = Get-Process $ProcessName -ea SilentlyContinue
    if($Null -eq $IsRunning){
        Start-Process ".\$ProcessName.exe"
    }else{
        Write-Output "$ProcessName is already running"
    }

}

Write-Output "Starting Aki Server"
Launch-If-Closed -ProcessName "Aki.Server"

Write-Output "Waiting for server to start"
while ($true) {
    try{
        if ($(Invoke-WebRequest -Uri http://127.0.0.1:6969/launcher/server/version).StatusCode -eq 200) {
            Write-Output "Starting Aki Client"
            Launch-If-Closed -ProcessName "Aki.Launcher"
            break
        }
    }catch{
        # ignore
    }
    Start-Sleep -Seconds 3
}
