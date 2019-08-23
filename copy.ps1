[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$currentPath = Get-Location
$destinationPath = $currentPath

$configPath = Join-Path $currentPath "config.json"

$config = Get-Content $configPath -Raw | ConvertFrom-Json
if ($config -and $config.outputPath) {
	$destinationPath = $config.outputPath
}

$cdmPath = Join-Path $HOME "appdata\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
Get-ChildItem $cdmPath | 
Foreach-Object {
	$sourceFileName = $_.FullName
	$fileName = Split-Path $sourceFileName -leaf
	$destinationFileName = (Join-Path $destinationPath $fileName) + ".jpg"
	$destinationBadFileName = (Join-Path $currentPath "bad" | Join-Path -childpath $fileName) + ".jpg"

	if (![System.IO.File]::Exists($destinationFileName) -and ![System.IO.File]::Exists($destinationBadFileName)) {
		try {
			$img = [System.Drawing.Image]::FromFile($sourceFileName)
			$width = $img.Width
			$height = $img.Height
			$img.Dispose()    
			
			if (($width -gt 1000) -and ($width -gt $height)) {
				Copy-Item $sourceFileName -Destination $destinationFileName
			}
		} catch [system.exception] {
			"caught a system exception: " +  $sourceFileName
		}
	}
}
