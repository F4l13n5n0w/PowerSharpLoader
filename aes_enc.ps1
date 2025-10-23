param (
    [string]$InputFilePath,
    [string]$OutputFilePath,
    [string]$Password
)

function Get-AesKey {
    param (
        [string]$Password,
        [byte[]]$Salt
    )
    $keyDeriver = New-Object System.Security.Cryptography.Rfc2898DeriveBytes($Password, $Salt, 10000)
    return $keyDeriver.GetBytes(32)  # AES-256
}

# Read binary data
$plainBytes = [System.IO.File]::ReadAllBytes($InputFilePath)

# Generate salt and IV
$salt = New-Object byte[] 16
[System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($salt)

$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Mode = 'CBC'
$aes.Padding = 'PKCS7'
$aes.Key = Get-AesKey -Password $Password -Salt $salt
$aes.GenerateIV()

$encryptor = $aes.CreateEncryptor()
$cipherBytes = $encryptor.TransformFinalBlock($plainBytes, 0, $plainBytes.Length)

# Combine salt + IV + ciphertext
$finalBytes = $salt + $aes.IV + $cipherBytes

# Write encrypted data to output file
$aes_b64_Data = [System.Convert]::ToBase64String($finalBytes)

#[System.IO.File]::WriteAllBytes($OutputFilePath, $aes_b64_Data)

Set-Content -Path $OutputFilePath -Value $aes_b64_Data -Encoding UTF8

Write-Host "Encryption complete. Encrypted file saved to $OutputFilePath"