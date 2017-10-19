'Option Explict
'On Error Resume Next

'; all erase except:
'; 1. last 3 week (24)
'; 2. each 1, 8, 15, 22 day of month for last 10 week (10)
'; 3. each 1, 15 day of month for last 12 month (24)
'; 4. each first day 1, 4, 7, 10 month of year 

Sub processFile(objFile)
	
	Dim fileMustBeErase
	Dim creationDate
	
	Set fileMustBeErase = True
	Set creationDate = objFile.DateCreated
	
	If (creationDate)
	
	WScript.Echo objFile.Name+" -- " & objFile.DateCreated

End Sub

Sub processFolder(folderPath)
	
	Dim objFSO
	Dim objFolder
	Dim objSubFolders
	Dim colFiles

	Set objFSO = CreateObject("Scripting.FileSystemObject")
	Set objFolder = objFSO.GetFolder(folderPath)
	Set colSubFolders = objFolder.SubFolders
	Set colFiles = objFolder.Files
	
	For Each objSubFolder in colSubFolders
		If (objSubFolder.Name <> ".git") Then
			processFolder(folderPath+"\"+objSubFolder.Name)
		End If
	Next

	For Each objFile in colFiles
		If (Right(objFile.Name,4) = ".bak") Then
'			WScript.Echo folderPath+"  "+objFiles.Name
			Call processFile(objFile)
		End If
	Next
	
End Sub

Call processFolder(".")