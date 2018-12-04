param(
    [alias("c","csv")]
    [string]$CSVFile = "C:\mailboxes.csv"
)

if(test-path($CSVFile)){
    remove-item $CSVFile   
}

get-mailbox -recipientTypeDetails "UserMailbox","SharedMailbox"| foreach-object{

    $Name = $_.Name
    $AliasList= ""

    for($i=0;$i -lt $_.emailaddresses.count;$i++){
        
        $Address = $_.emailaddresses[$i]

        if($Address.isPrimaryAddress -eq $True){
            $AddressAsString = [string]$Address
            $AddressToPrint = $AddressAsString.substring(5)
        }else{
            $AliasAsString = [string]$Address
            $AliasToPrint = $AliasAsString.substring(5)
            $AliasList += "$AliasToPrint,"
        }    
    }

    $MailboxLineToCSV = ("$Name,$AddressToPrint,$AliasList").trimend(",")
    add-content -path $CSVFile -Value $MailboxLineToCSV

}


Get-DistributionGroup | foreach-object{

    $Name=$_.Name
    $AliasList= ""

    for($i=0;$i -lt $_.emailaddresses.count;$i++){

        $Address = $_.emailaddresses[$i]
        
        if($Address.isPrimaryAddress -eq $True){
            $AddressAsString = [string]$Address
            $AddressToPrint = $AddressAsString.substring(5)
        }else{
            $AliasAsString = [string]$Address
            $AliasToPrint = $AliasAsString.substring(5)
            $AliasList += "$AliasToPrint,"
        }    
    }

    $MailboxLineToCSV = ("$Name,$AddressToPrint,$AliasList").trimend(",")
    add-content -path $CSVFile -Value $MailboxLineToCSV

}

