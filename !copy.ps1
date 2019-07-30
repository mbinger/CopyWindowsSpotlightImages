[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$currentPath = Get-Location
$cdmPath = Join-Path $HOME "appdata\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
Get-ChildItem $cdmPath | 
Foreach-Object {
	$sourceFileName = $_.FullName
	$fileName = Split-Path $sourceFileName -leaf
	$destinationFileName = (Join-Path $currentPath $fileName) + ".jpg"

	if (![System.IO.File]::Exists($destinationFileName)) {
		$img = [System.Drawing.Image]::FromFile($sourceFileName)
		$width = $img.Width
		$height = $img.Height
		$img.Dispose()    
		
		if (($width -gt 1000) -and ($width -gt $height)) {
			Copy-Item $sourceFileName -Destination $destinationFileName
		}
	}
}