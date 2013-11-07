#create object for web request
$request_url = "https://college.uchicago.edu"
$request = Invoke-WebRequest -Uri $request_url;
