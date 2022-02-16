$localPath = 'T:'
$domain = (Get-SSMParameterValue -Region us-east-2 -Name fsx_domain).Parameters[0].Value
$username = (Get-SSMParameterValue -Region us-east-2 -Name fsx_username).Parameters[0].Value
$password = (Get-SSMParameterValue -Region us-east-2 -Name fsx_password -WithDecryption $true).Parameters[0].Value | ConvertTo-SecureString -AsPlainText -Force
$domainUsername = $domain + '\' + $username
Write-Host "Host: $($domainUsername)"
Write-Output "Output: $($domainUsername)"
$credential = New-Object System.Management.Automation.PSCredential($domainUsername, $password)
New-SmbGlobalMapping -RemotePath '\\198.19.255.25\lee' -Credential $credential -LocalPath $localPath -RequirePrivacy $true -ErrorAction Stop
"$(Get-Date -Format 'dd-MM-yyyy HH:mm:ss') $(hostname)" | Out-File -FilePath "$($localPath)\eks_host.log" -Encoding ASCII -Append
