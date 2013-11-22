$links = $args[0]
Write-Host "The link expression is:   $links"
$search_index = $links.length
Write-Host "The length of this thing is $search_index"
$buffer = ""

for($i = 0; $i -lt $search_index; $i++)
	{
		Write-Host "We are in the outer loop. i = $i";
		Write-Host "The current letter is " -nonewline
		Write-Host $links[$i]
		
				Write-Host "Checking that we are getting an href, i = $i"
				
				#check if we have a link tag, if so, begin writing
				if(($links.substring($i,5).compareTo("href=")) -eq 0)
				{
					Write-Host "Inside check adding constant to i, i = $i"

					$i += 5;
					#begin writing
					while (($links[$i].toString().compareTo(">")) -ne 0)
						{
							Write-Host "Inside check for > character, i = $i"
							$buffer = $buffer + $links[$i].toString();
							$i++;
						}
					$buffer = $buffer + "`n";
					
				}

	}

Write-Host $buffer