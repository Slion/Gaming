
Write-Host "Copying MW5 user settings and joystick remap..."
Copy-Item "${env:LOCALAPPDATA}\MW5Mercs\Saved\Config\WindowsNoEditor\GameUserSettings.ini"
Copy-Item "${env:LOCALAPPDATA}\MW5Mercs\Saved\SavedHOTAS\HOTASMappings.Remap"
Write-Host "Done!"