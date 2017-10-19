'Option Explict
'On Error Resume Next

Dim objFSO
Dim objFolder
Dim colFiles

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFolder = objFSO.GetFolder(".")
Set colFiles = objFolder.Files

For Each objFiles in colFiles
	WScript.Echo objFiles.Name
Next