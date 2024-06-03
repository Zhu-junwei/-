# 生成二维码
function Generate-QRCode {
    param (
        [string]$Text,
        [string]$OutputPath = "qrcode.png"
    )

    $url = "https://api.qrserver.com/v1/create-qr-code/?data=$Text&size=200x200"
    Invoke-WebRequest -Uri $url -OutFile $OutputPath

    Write-Host "QR Code saved to $OutputPath"
}

$text = Read-Host "Enter the text for the QR code"
$outputPath = Read-Host "Enter the output file path" -Default "qrcode.png"
Generate-QRCode -Text $text -OutputPath $outputPath

# 暂停终端，等待用户输入
Read-Host "Press Enter to exit"
