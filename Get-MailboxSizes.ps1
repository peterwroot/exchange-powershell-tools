#File that the results will be written to
$File = "C:\MailboxSizes.csv"

#Removes the $file if it already exists
if(test-path $File){
    Remove-Item $File
}

#Writes the top row for the csv file
Add-Content -Path $File -Value "Mailbox,Size (GB)"

#Gets a list of all mailboxes, then extracts the size in GB for each. 
get-mailbox | ForEach-Object{
    #Sets the variable to the user's email address so we can write it to the CSV later.
    $MailboxStatUser = $_.PrimarySMTPAddress
    #Gets the size of the mailbox in bytes. This is too small for us to use!!
    $MailboxStatSizeRaw = Get-MailboxStatistics $_.Alias | Select-Object -expandproperty TotalItemSize
    #Transforms the mailbox size from bytes into MB, then divides by 1024 to give us the size in gigabytes.
    #I don't use 'Value.ToGB' as I don't like the way it rounds to whole numbers.  
    $MailboxStatSizeGBRaw = (($MailboxStatSizeRaw.value.toMB()) / 1024)
    #Rounds the mailbox size in gigabytes to two decimal places. 
    $MailboxStatSizeGBFormatted = [math]::Round($MailboxStatSizeGBRaw,2)
    #The variable written to the CSV file. 
    $CSVOutLine = "$MailboxStatUser,$MailboxStatSizeGBFormatted"
    #Writes to the CSV file. 
    Add-Content -Path $File -Value $CSVOutLine
}

write-host "List saved to C:\MailboxSizes.csv"