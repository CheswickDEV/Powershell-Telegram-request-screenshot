$token="BOTToken"
$wshell = New-Object -ComObject wscript.shell;
Add-Type -Assembly System.Drawing
function Get-Screenshot
{
 param([System.Drawing.Rectangle]$Bereich,[Switch]$Show=$false)
 $Bmp = New-Object System.Drawing.Bitmap $Bereich.Width, $Bereich.Height
 $Graphics = [System.Drawing.Graphics]::FromImage($Bmp)
 $Graphics.CopyFromScreen($Bereich.Location, [System.Drawing.Point]::Empty,$Bereich.Size)
 $BmpPath = "C:\XXXX\$Name.png"
 $Bmp.Save($BmpPath)
 $Graphics.Dispose()
 $Bmp.Dispose()
 if ($Show)
 { Invoke-Item -Path $BmpPath }
}
 
while($true){
 
 
$res = Invoke-RestMethod https://api.telegram.org/bot$token/getUpdates -Method Get 
$Name = $res.result.message.text | Select-Object -Last 1
$SendID = $res.result.message.from.id | Select-Object -Last 1
$filepath="C:\XXXX\$Name.png"
 
 
if ($Name -match "Beispiel1"){
 
$sig = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
Add-Type -MemberDefinition $sig -name NativeMethods -namespace Win32
$hwnd = @(Get-Process "Hier Prozess Einfügen")[0].MainWindowHandle
[Win32.NativeMethods]::ShowWindowAsync($hwnd, 2)
[Win32.NativeMethods]::ShowWindowAsync($hwnd, 4)
[Win32.NativeMethods]::ShowWindowAsync($hwnd, 2)
[Win32.NativeMethods]::ShowWindowAsync($hwnd, 4)
 
Start-sleep -Milliseconds 400
#Hier werden die Koordinaten für den Bereich wo der Screenshot gemacht werden soll festgelegt. Weil unser Schichtplaner keine API bietet
$Bereich = [System.Drawing.Rectangle]::FromLTRB(0, 110, 568, 555)
Get-Screenshot -Bereich $Bereich 
 
Invoke-RestMethod "https://api.telegram.org/bot$token/sendMessage?chat_id=$SendID&text=Hallo $Name Bitte gib dein Passwort an: " -Method Get
 
Start-sleep -Seconds 60
$PWres = Invoke-RestMethod https://api.telegram.org/bot$token/getUpdates -Method Get 
$PWID= $PWres.result.message.text | Select-Object -Last 1
 
    if ($PWID -match "PWfürjedenUserhinterlegen"){
 
Start-Process -NoNewWindow -FilePath "C:\XXX\mycurl\curl.exe" -ArgumentList " -k -X POST -H ""Content-Type: multipart/form-data"" -F ""photo=@$filepath"" ""https://api.telegram.org/bot$token/sendPhoto?chat_id=$SendID"""
Start-Sleep -Seconds 120
 
 
    else {
        "Passwort war Falsch."
    Start-sleep -Seconds 120
}
 
else{
"Keine Anfrage"
Start-sleep -Seconds 120
}
 
}