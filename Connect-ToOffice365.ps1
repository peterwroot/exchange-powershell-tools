clear-host

#Writes opening Text
write-host "--- Connect-ToOffice365 ---`n"
write-host "A script to make connecting"
write-host "to Office 365's Exchange"
write-host "control panel nice and easy.`n"

#Instructions according to:
#https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?view=exchange-ps

#Credential Prompt
$ConnectionCredential = Get-Credential -Message "Please enter your Office 365 Credentials" -Verbose:$false 

#Creates the PowerShell Session
$ExchangeOnlinePSSesstion = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $ConnectionCredential -Authentication Basic -AllowRedirection -Verbose:$false

#Joins the PowerShell session
enter-PSSession $ExchangeOnlinePSSesstion 

#End Text. 
Write-Host "You are now connected to Office 365."
Write-host "To leave this session, enter 'Exit-PSSession'"


