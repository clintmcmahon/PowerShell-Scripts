[void][system.reflection.assembly]::loadwithpartialname("Microsoft.Office.Server.UserProfiles")

#Add SharePoint PowerShell SnapIn if not already added 
if ((Get-PSSnapin "Microsoft.SharePoint.PowerShell" -ErrorAction SilentlyContinue) -eq $null) { 
    Add-PSSnapin "Microsoft.SharePoint.PowerShell" 
} 
 
$csvFile = "c:\data.csv"
$MySiteUrl = "http://URL"

$site = new-object Microsoft.SharePoint.SPSite($MySiteUrl);  
$ServiceContext = [Microsoft.SharePoint.SPServiceContext]::GetContext($site);  

$ProfileManager = new-object Microsoft.Office.Server.UserProfiles.UserProfileManager($ServiceContext)    

$csv = import-csv -path $csvFile

foreach ($line in $csv)
{
	$user_name = 'DOMAIN\' + $line.username
	$up = $profileManager.GetUserProfile($user_name)
	
	if($up)
	{
		$up["PictureURL"].Value = $line.value
		$up.Commit()
		
		write-host "SharePoint photo updated for " $user_name,"--->",$up.DisplayName,"--->",$line.value
		$up = $null
	}
}

Run this separately after the above code
#Update-SPProfilePhotoStore -MySiteHostLocation http://mysite.rkmc.com/