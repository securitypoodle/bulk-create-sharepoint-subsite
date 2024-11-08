$SiteCollURL = "https://DOMAIN.sharepoint.com/sites/SUBSITE"

# If you have MFA enabled, use an App Password in your credentials when prompted below
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
