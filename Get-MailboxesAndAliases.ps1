param(
    [alias("c","csv")]
    [string]$CSVFile = "C:\mailboxes.csv"
)

if(test-path($CSVFile)){
    
    remove-item $CSVFile   
}

Add-Content -Path $CSVFile -Value "Name,Primary Address,Aliases"

get-mailbox -recipientTypeDetails "UserMailbox","SharedMailbox"| foreach-object{

    $Name = $_.DisplayName
    $AliasList= ""
    $PrimaryAddress= $_.PrimarySMTPAddress

    for($i=0;$i -lt $_.emailaddresses.count;$i++){
        
        [string]$Address = $_.emailaddresses[$i]
        $AddressSubstring = $Address.substring(5)

        if($AddressSubstring -eq $PrimaryAddress){
            $AddressToPrint = $AddressSubstring          
        }else{
            $AliasAsString = [string]$Address
            $AliasToPrint = $AliasAsString.substring(5)
            $AliasList += "$AliasToPrint,"
        }    
    }

    $MailboxLineToCSV = ("$Name,$AddressToPrint,$AliasList").trimend(",")
    write-host $MailboxLineToCSV
    add-content -path $CSVFile -Value $MailboxLineToCSV

}


Get-DistributionGroup | foreach-object{

    $Name = $_.DisplayName
    $AliasList= ""
    $PrimaryAddress= $_.PrimarySMTPAddress

    for($i=0;$i -lt $_.emailaddresses.count;$i++){
        
        [string]$Address = $_.emailaddresses[$i]
        $AddressSubstring = $Address.substring(5)

        if($AddressSubstring -eq $PrimaryAddress){
            $AddressToPrint = $AddressSubstring          
        }else{
            $AliasAsString = [string]$Address
            $AliasToPrint = $AliasAsString.substring(5)
            $AliasList += "$AliasToPrint,"
        }    
    }

    $MailboxLineToCSV = ("$Name,$AddressToPrint,$AliasList").trimend(",")
    write-host $MailboxLineToCSV
    add-content -path $CSVFile -Value $MailboxLineToCSV

}

