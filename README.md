# SPT-AKI-Shortcut

**I wrote this as a convenience script for myself.  Since I used the [SPT AKI Installer](https://hub.sp-tarkov.com/files/file/672-spt-aki-installer/), some assumptions were made about executable names.  That means that this may not work out of the box for you, if you didn't use that installer.**

Launch both Aki.Server and Aki.Client from 1 simple shortcut.

### Start Here
* Clone this repo OR Download the repo files
* Execute the script `install.ps1`
    * If you don't know how execute the script, use 1 of these 2 options:
        * Right click on `install.ps1` and click "Run With Powershell"
        * Open Powershell, CD to folder, run `./install.ps1`

### Info
* `install.ps1` copies the `start_aki.ps1` to your aki installation path, and then creates a shortcut on your desktop.
* `start_aki.ps1` starts the server, and then pokes local rest api for a 200 status code.  Once that 200 is recieved, it starts the client. 
