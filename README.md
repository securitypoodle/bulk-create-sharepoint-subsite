# bulk-create-sharepoint-subsite
This powershell script creates multiple Sharepoint Online Subsites referrencing a pre-built CSV.

This was originally created circa 2019 to automate a yearly (and extremely) manual process of creating multiple subsites within Microsoft Sharepoint Online. 

## Use Case
The Sharepoint environment was utilized as a customer-facing portal for securely sharing documents. For "reasons", the company needed to create a new subsite per customer each year. As such, a site was created for 2020, 2019, 2018, etc. For each year's site, a subsite was created for each customer (i.e. `/2020/CustomerA, /2020/CustomerB, etc`). This led to a manual process that consumed roughly 2-3 weeks of analyst time clicking through the Sharepoint portal to create the site, apply the appropriate name, and import a pre-determined folder structure so customers could share documents back and forth with the company's team. The time of 2-3 weeks was determined by how many customer portals needed to be created - each year a roughly estimated 150+ portals/subsites would need to be created, each one taking anywhere between 10-20 minutes to create (due to Sharepoint website load times).

## Automated Solution
So what do we do with a manual process that takes dozens of hours? Automate it!

The company's business unit already maintained a list of customers, so we leveraged this and had a CSV export generated for our use. From the CSV, I used the following data:
- Customer name (for Subsite Name)
- Customer acronym (for Subsite URL)
Additional data was added for Sharepoint-specifics:
- Description (copy from Customer name, could be anything else)
- Locale (The language id of the new web. Default = 1033 for English)
- Template (Template ID to use when creating the new site)
Once complete, the CSV should look similar to this:
![image](https://github.com/user-attachments/assets/fce92529-84e6-4240-951b-f55b708ef43b)

### ! Note on Template ID !
Template ID is required to create a Sharepoint (sub)site. There are a number of default templates to choose from, however, for our use case, we need to create a Template from scratch. This customized template allows us to chose the type of site (in this case "Document Center"), as well as upload our pre-determined folder structure. When a site is created with this custom template, all necessary settings are pre-configured and will require zero user interaction once the script completes. Creating the custom template and retrieving it's ID is necessary to fully automate this process. You can find your Template ID from the following methods:
- [Sharepoint Site Template ID Reference](https://www.technologytobusiness.com/microsoft-sharepoint/sharepoint-online-site-template-id)
- [Using web browser developer tools](https://sharepoint.stackexchange.com/questions/191990/how-do-i-determine-subsite-template)
- [Using Powershell](https://www.sharepointdiary.com/2019/04/find-site-template-in-sharepoint-online-using-powershell.html)

I personally used option #2 (web browser developer tools)

## The code
`bulk-create-subsite.ps1` 

This script leverages PnP PowerShell cmdlets to:
- Authenticate to Sharepoint Online via `Connect-PnPOnline` ([reference](https://learn.microsoft.com/en-us/sharepoint/dev/declarative-customization/site-design-pnppowershell))

  *Note: authentication may differ depending on method (basic vs OAuth)*
- Create new subsite based on an existing site (or subsite) via `New-PnPWeb` ([reference](https://pnp.github.io/powershell/cmdlets/New-PnPWeb.html))

| variable | description |
| -------- | ----------- |
| $SiteCollURL | This variable is the site you want to bulk create subsites under. In our use case above, this would be something like `https://DOMAIN.sharepoint.com/sites/<2020>` |
| $file | This variable references the file location of your CSV. In our use case, we saved the CSV to the current working directory of our poweshell window. |
| $SiteTitle | This variable references the value in the "SiteTitle" column of our CSV. |
| $SiteURL | This variable references the value in the "URL" column of our CSV. |
| $Description | This variable references the value in the "Description" column of our CSV. |
| $Locale | This variable references the value in the "Locale" column of our CSV. |
| $Template | This variable references the value in the "Template" column of our CSV. |

## Results
If all is successful, you should see the output on your screen!

*Screenshot below shows `/TestPortal` in place of `/2020` for our use case above, but funcionality is the same.*

![image](https://github.com/user-attachments/assets/e8918cba-a044-42a5-ac91-065effa1cfb5)
