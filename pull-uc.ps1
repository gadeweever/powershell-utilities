#create object for web request
$request_predicate = "/student-life/student-groups"
$request_url = [string]::Concat("https://college.uchicago.edu", $request_predicate);
$request = Invoke-WebRequest -Uri $request_url;
$request.Links > "links.txt"
$request.Content > "content.txt"
$request.ParsedHTML > "parsedContent.txt"
$request.Headers > "headers.txt"
$request_final = [string]::Concat($request_predicate,"Final.txt");

#create control variables
$pattern = "";
$search_index = 0;
$links = "";
$buffer = "";

$search_txt = ".\content.txt"
$search_obj = Select-String -Pattern "contentPage" -Path $search_txt

$search_index = $search_obj.LineNumber[0];
# Write-Host "$search_index is your index";

$to_add = Select-String -Pattern "href=" -Path $search_txt;
$num_links = $to_add.length;

for($i = 0; $i -le $num_links; $i++)
{
	if($to_add[$i].LineNumber -ge $search_index)
		{
			if($to_add[$i].LineNumber -le $search_obj[1].LineNumber)
				{
					$links = [string]::Concat($links, $to_add[$i].Line,"`n");
				}
		}
}

# for purposes of the page, these tages are filtered out
$links = $links.Replace("<h4>", "");
$links = $links.Replace("</h4>", "");
$links = $links.Replace("<h3>", "");
$links = $links.Replace("</h3>", "");
$links = $links.Replace("href=", "");


# pass to create a new string with just links
# $search_index = $links.length;
# for($i = 0; $i -lt $search_index; $i++)
# 	{
# 		#check if we have a link tag, if so, begin writing
# 		if(($links.substring($i,$i+2).compareTo("<a")))
# 			{
# 				$i = $i + 2;
# 				#begin writing
# 				while (-not ($links[$i].toString().compareTo(">")))
# 					{
# 						$buffer = $buffer + $links[$i].toString();
# 						$i++;
# 					}
# 				$buffer = $buffer + "`n";
					
# 			}
# 		else
# 			{
# 				$i++;
# 			}

# 	}


$links > "student-groups.txt";

