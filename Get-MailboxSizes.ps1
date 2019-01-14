$File = "C:\MailboxSizes.csv"

if(test-path $File){
    Remove-Item $File
}

Add-Content -Path $File -Value "Mailbox,Size"

get-mailbox | foreach{

$MailboxStatUser = $_.PrimarySMTPAddress
$MailboxStatSize = Get-MailboxStatistics $_.Alias | Select-Object -ExpandProperty TotalItemSize 

$CSVOutLine = "$MailboxStatUser,$MailboxStatSize"
 
Add-Content -Path $File -Value $CSVOutLine

}