# ARM Template
ARM Template which provisions resource group with such Resources:
* SQL Server
* Service Bus 
* Service Plan
* Application Insight
* WebApp with connectionstring to db

Deploy template to a resource group Develop in West Europe region with Staging slots for WebApps 
```sh
$cred = Get-Credential
$Sub1 = 'Subscription'
Login-AzureRmAccount -Credential $cred
Get-AzureRmSubscription 
Select-AzureRmSubscription -SubscriptionName $Sub1
./deploy.ps1 -ApplicationName testwebapp -ResourceGroupSuffix Develop -RG_Location westeurope
```