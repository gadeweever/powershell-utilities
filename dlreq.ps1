#this script will download individual information for the directory
#using an Invoke-WebRequest and a lower bound
#the amount of pages to download is set below

#out-file stores the current bound to download from
$out_file = "bound.txt"
#control variable
$i = 0
#starting index for downloading pages; retrieved from $out_file
$low_bound = [int](Get-Content ".\$out_file")
#variable for amount of pages to downlpad
$num_pages = 100
#Time between server request
$wait_period = 200
$interval = 60

#clear cache of errors
$error.Clear();

#control loop for downloading pages
Write-Host "Beginning download of $num_pages pages!"

while($i -le $num_pages){
	$my_url = [string]::Concat("https://directory.uchicago.edu/individuals/",$low_bound);
	$hsg = Invoke-WebRequest -Uri $my_url;
	#if there was no error, create a new file, direct content, increment variable
	if($error.count -eq 0)
		{
			$file_name = [string]::Concat("index",$low_bound,".html");
			$hsg.Content > $file_name;
			Write-Host "Found a page! on index $i.";
			$i = $i + 1;
		}
	#if the page did not exist clear the cache and do noting
	else{
			$error.Clear();
		}
	
	$low_bound = $low_bound + 1;
	#increases time between page request in millisecons
	Start-Sleep -m $wait_period;

}

#writes next download number to file
$low_bound > $out_file;

#comments for outputting feedback to user
Write-Host "FINISHED! Your last index is $low_bound."
Write-Host "Finished writing to file $out_file"

#clean up for more powershell useage (not necessary)
$i = 0;

