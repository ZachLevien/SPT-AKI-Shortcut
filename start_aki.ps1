function Launch-If-Closed {
    param (
        $ProcessName
    )

    $IsRunning = Get-Process $ProcessName -ea SilentlyContinue
    if( $IsRunning -eq $Null ){
        Start-Process ".\$ProcessName.exe"
    }else{
        echo "$ProcessName is already running"
    }

}

echo "Starting Aki Server"
Launch-If-Closed -ProcessName "Aki.Server"

echo "Waiting for server to start"
while ($true) {
    try{
        if ($(curl -Uri http://127.0.0.1:6969/launcher/server/version).StatusCode -eq 200) {
            echo "Starting Aki Client"
            Launch-If-Closed -ProcessName "Aki.Launcher"
            break
        }
    }catch{
        # ignore
    }
    Start-Sleep -Seconds 3
}
