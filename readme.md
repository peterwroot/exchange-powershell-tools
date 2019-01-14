# Exchange Powershell Tools

My PowerShell scripts for working with Microsoft Exchange.

## Get-MailboxesAndAliases.ps1

Exports a CSV file of all Microsoft Exchange User Mailboxes, Shared Mailboxes, and Distribution Lists.

The CSV is in the format:
`Name,PrimarySMTPAddress,Alias,Alias,Alias`

## Connect-ToOffice365.ps1

Simple script to automate connecting to Exchange Online using PowerShell.

## Get-MailboxSizes.ps1

Quick and dirty script to find the mailbox sizes for all exchange users. Writes to C:\MailboxSizes.csv