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
$TemplateFile = 'deploy.json'
$ResourceGroupName = 'Testing'
$Location = "West EU"
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location 
New-AzureRmResourceGroupDeployment -Name ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')) `
                                   -ResourceGroupName $ResourceGroupName `
                                   -TemplateFile $TemplateFile `
                                   -Force `
                                   -Verbose 
```