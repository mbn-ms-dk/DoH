# Deploy to Azure Container Apps using bicep

1. login
```powershell 
az login
```

2. Add containerapp extension
```powershell
az extension add --name containerapp --upgrade
az provider register --namespace Microsoft.App
```

3. Set environment variables
```powershell 
$rg="rg-oidc"
$loc="northeurope"
```

4. Create resource group
```powershell 
az group create --name $rg --location $loc
```

5. Deploy 
```powershell
az deployment group create --resource-group $rg --template-file "./bicep/main.bicep" --parameters "./bicep/main.parameters.json"
```