#Update the default SharePoint text in the upper left corner of the master page to a custom link and text

#Get the webapp to update
$webApp = Get-SPWebApplication http://URL

#Set the html of the element and update
$webApp.SuiteBarBrandingElementHtml = '<div class="ms-core-brandingText"><a href="{custom url}" class="ms-core-suiteLink-a" style="{display: inline; padding-left: 0px;} :hover {background-color: transparent;}">{text}</a></div>'
$webApp.Update()
