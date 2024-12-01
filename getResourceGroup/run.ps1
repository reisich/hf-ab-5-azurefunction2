using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "Get Azure Resource Groups"

#Select-AzSubscription -Subscription d17430d0-abd6-4646-ba82-6356532ab5df
$body = Get-AzResourceGroup | ConvertTo-Json

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
