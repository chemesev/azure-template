Param(
    [Parameter(Mandatory=$true)]
    [string] $ApplicationName, 
	[string] $ResourceGroupSuffix = "Test",
    [string] $RG_Location = "westeurope",
	[string] $TemplateFile = ".\deploy.json",
	[string] $TemplateParameterFile = ".\parameters.script.json", 
    [string] $SlotName = "Staging"       
)
#create Resource Group Name
$RG_Name = "$ApplicationName-$ResourceGroupSuffix"

if (!(Test-Path ".\$TemplateFile")) 
{
	Write-Host "template not found" -ForegroundColor Red
}
elseif (!(Test-Path ".\$TemplateParameterFile")) 
{
	Write-Host "parameters not found" -ForegroundColor Red
}
else 
{
	Write-Host "Checking we logged in..."
	Get-AzureRmSubscription

	#Set parameters in parameter file and save to temp.json
	(Get-Content ".\${TemplateParameterFile}" -Raw) `
		-replace "{NAME}",$ApplicationName `
		-replace "{SUFFIX}",$ResourceGroupSuffix `
		-replace "{SLOTNAME}",$SlotName |
			Set-Content .\temp.json
		
	Write-Host "$RG_Name - Creating Resource Group, App Service Plan, Web Apps and SQL Database..." -ForegroundColor Green 
	try 
	{
		#Missing parameters in the parameters file, such as sqlServerAdminLogin and sqlServerAdminPassword, will be
		#prompted automatically and securely
		New-AzureRmResourceGroup -Verbose `
			-name $RG_Name `
			-location $RG_Location `
			-ErrorAction Stop
        
        New-AzureRmResourceGroupDeployment `
            -name $RG_Name.ToLower() `
            -ResourceGroupName $RG_Name.ToLower() `
            -TemplateFile ".\$TemplateFile" `
			-TemplateParameterFile ".\temp.json"
	}
	catch 
	{
    	Write-Host $Error[0] -ForegroundColor Red 
    	exit 1 
	} 
	finally
	{
		Remove-Item .\temp.json | Out-Null

		Write-Host $file "Deployment complete"  -ForegroundColor Green
	} 
}