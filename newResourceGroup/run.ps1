using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Interact with query parameters or the body of the request.
$data = $Request.Body

$xforwardedfor = $Request.Headers."X-Forwarded-For"
$ip = $xforwardedfor -replace ":\d+$", ""

write-host $data.name

if(New-AzResourceGroup -Name $data.name -Location $data.location -Tag @{clientip=$ip}) {
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::OK
        Body = "created"
    })
} else {
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::ERROR
        Body = "failed"
    })
}
