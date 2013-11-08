#create object for web request
$request_predicate = "/student-life/annual-events"
$request_url = [string]::Concat("https://college.uchicago.edu", $request_predicate);
$request = Invoke-WebRequest -Uri $request_url;
$request.Links > "links.txt"
$request.Content > "content.txt"
$request.ParsedHTML > "parsedContent.txt"
$request.Headers > "headers.txt"


$pattern = "";
$search_index = 0;
$links = ""

$num_tag = 1;
$got_div = $False;

$search_txt = ".\content.txt"
$search_obj = Select-String -Pattern "contentPage" -Path $search_txt

$search_index = $search_obj.LineNumber[0];
$search_range = $search_obj.LineNumber[1] - $search_obj.LineNumber[0];
Write-Host "$search_index is your index";

$to_add = Select-String -Pattern "href=" -Path $search_txt;
$num_links = $to_add.length;

for($i = 0; $i -le $num_links; $i++)
{
	if($to_add[$i].LineNumber -ge $search_index)
		{
			if($to_add[$i].LineNumber -le $search_obj[1].LineNumber)
				{
					$links = [string]::Concat($links, $to_add[$i].Line,"\n");
				}
		}
}





# while($num_tag -ge 1)
# {
	
# 	$to_add = Select-String -Pattern "href=" -Path $search_txt;
# 	$links = [string]::Concat($links, $to_add.Line);
# 	$got_div = Select-string -context $search_index -Pattern "<div>" -Path $search_txt -Quiet;
# 	if($got_div)
# 		{
# 			$num_tag = $num_tag + 1;
# 		}
# 	$got_div = $False;
# 	$got_div = Select-string -context $search_index -Pattern "</div>" -Path $search_txt -Quiet;
# 	if($got_div)
# 		{
# 			$num_tag = $num_tag - 1;
# 		}
# 	$got_div = $False;
# 	$search_index = $search_index + 1;


# }

$links > [string]::Concat($request_predicate,"Final.txt");
