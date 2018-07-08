# ARM Template
ARM Template which provisions resource group with such Resources:
* SQL Server
* Service Bus 
* Service Plan
* FrontEnd WebApp
* BackEnd WebApp with connectionstring to db

1) App Service Plan - hosting plan for application service
2) Application Insight
3) SQL server and a database - template for Sql server/database.
4) Service Bus

Deploy template to a resource group Develop in West Europe region with Staging slots for WebApps 
```sh
.\deploy.ps1 -ResourceGroupSuffix Develop -RG_Location "West Europe" -SlotName Staging
```
