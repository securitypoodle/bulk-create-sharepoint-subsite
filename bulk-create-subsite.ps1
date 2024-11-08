$SiteCollURL = "https://DOMAIN.sharepoint.com/sites/SUBSITE"

# Authentication can vary depending on method configured.
# >> Basic auth may need an App Password input when prompted
# >> OAuth may prompt you for normal creds, and then MFA (if enabled)

Connect-PnPOnline -Url $SiteCollURL -Credentials $Cred

$file = Import-Csv .\TestPortal.csv

foreach ($line in $file)
{
    $SiteTitle = $line.SiteTitle
    $SiteURL = $line.URL
    $Description = $line.Description
    $Locale = $line.Locale
    $Template = $line.Template
    
    New-PnPWeb -Title $SiteTitle -Url $SiteURL -Description $Description -Locale $Locale -Template $Template -ErrorAction Stop
    Write-host "Site '$SiteTitle' Created Successfully!" -f Green
}
