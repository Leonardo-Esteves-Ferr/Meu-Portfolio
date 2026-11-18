#Chave maliciosa:

$chaveMaliciosa = "HKCU: \Software\Microsoft\Windows\CurrentVersion\Run\EncryptorMalicioso"

if (Test-Path $chaveMaliciosa) {
    Write-Host "Removendo chave maliciosa do Registro..."
    Remove-Item  -Path $chaveMaliciosa  -Force
    Write-Host "Chave maliciosa removida com sucesso."
} else {
      Write-Host "Nenhuma chave maliciosa encontrada no Registro."
}
_________________________________________________________________________________________
#Mensagem criptografada:

# Encryption Key (16, 24, or 32 bytes)
$encryptionKey = [Text.Encoding]::UTF8.GetBytes("MySecretEncryptionKey")
# Text to encrypt
$textToEncrypt = "SENAI 123."
# Convert the text to bytes
$bytesToEncrypt = [Text.Encoding]::UTF8.GetBytes($textToEncrypt)
# Create AES encryption object
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
$aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.Mode = [System.Security.Cryptography.CipherMode]::CBC
$aes.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7

# Generate a random IV (Initialization Vector)
$aes.GenerateIV()
# Create an encryption stream
$encryptor = $aes.CreateEncryptor()
# Encrypt the bytes
$encryptedBytes = $encryptor.TransformFinalBlock($bytesToEncrypt, 0, $bytesToEncrypt.Length)
# Convert the encrypted bytes to Base64 for storage
$encryptedText = [Convert]::ToBase64String($aes.IV + $encryptedBytes)
# Display the encrypted text
Write-Host "Encrypted Text: $encryptedText"
_________________________________________________________________________

#Descriptografia:

# Convert the Base64 encrypted text back to bytes
$encryptedBytesWithIV = [Convert]::FromBase64String($encryptedText)
$iv = $encryptedBytesWithIV[0..15]
$encryptedBytesOnly = $encryptedBytesWithIV[16..($encryptedBytesWithIV.Length - 1)]
# Set the IV and decrypt
$aes.IV = $iv
$decryptor = $aes.CreateDecryptor()
$decryptedBytes = $decryptor.TransformFinalBlock($encryptedBytesOnly, 0, $encryptedBytesOnly.Length)
# Convert the decrypted bytes back to text
$decryptedText = [Text.Encoding]::UTF8.GetString($decryptedBytes)
# Display the decrypted text
Write-Host "Decrypted Text: $decryptedText
_________________________________________________________________________

#Login:

Get-WinEvent -LogName Security | Where-Object { $_.Id  -eq 4624 -or $_.Id  -eq 4634 } | Select-Object -Property TimeCreated, Id,Message
_________________________________________________________________________
#Gerenciamento em segundo plano:


Get-Process | Where-Object {$_.Path -eq $null -and $_.Handles  -gt 500  -and $_.CPU -gt 50}

