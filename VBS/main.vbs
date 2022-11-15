set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

rem load config
scriptdir = fso.GetParentFolderName(WScript.ScriptFullName)
configFileName = fso.BuildPath(scriptdir, "config.json")
configJson = fso.OpenTextFile(configFileName).ReadAll

Set regex = New RegExp
regex.Pattern = """outputPath"":\s*""([^""]*)"
regex.Global = True
Set matches = regex.Execute(configJson)
destinationPath = Replace(matches(0).SubMatches(0), "\\", "\")

if Len(destinationPath) <= 0 Then
	WScript.Quit 255
end if

rem get windows CDN path
userProfilePath = shell.ExpandEnvironmentStrings("%USERPROFILE%")
windowsCdmPath = fso.BuildPath(userProfilePath, "\appdata\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets")
set windowsCdmFolder = fso.GetFolder(windowsCdmPath)

Set colFiles = windowsCdmFolder.Files
For Each objFile in colFiles
	sourceFullFileName = fso.BuildPath(windowsCdmPath, objFile.Name)
	destinationFullFileName = fso.BuildPath(destinationPath, objFile.Name & ".jpg")
	destinationBadFileName = fso.BuildPath(fso.BuildPath(destinationPath, "bad"), objFile.Name & ".jpg")
	
	if (not fso.FileExists(destinationFullFileName) and not fso.FileExists(destinationBadFileName)) then
		
		Set objImage = CreateObject("WIA.ImageFile")
		objImage.LoadFile sourceFullFileName
					
		if objImage.Width > 1000 and objImage.Width >= objImage.Height then
			fso.CopyFile sourceFullFileName, destinationFullFileName
		end if   			
	end if
Next
