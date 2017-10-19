'Option Explict
'On Error Resume Next

'; all erase except:
'; 1. last 3 week (24)
'; 2. each 1, 8, 15, 22 day of month for last 20 week (20)
'; 3. each 1, 15 day of month for last 12 month (24)
'; 4. each first day 1, 4, 7, 10 month of years 

Function processFile(objFile)
	
	Dim fileMustBeErase
	Dim creationDate
		
	fileMustBeErase = True
	
	' by stored creation date
	creationDate = objFile.DateCreated
	' or by name date
	creationDate = Mid(objFile.Name, InStr(objFile.Name, "backup")+7, 10)
	creationDate = "" & Mid(creationDate, 9, 2) & "/" & Mid(creationDate, 6, 2) & "/" & Mid(creationDate, 1, 4)
	creationDate = CDate(creationDate)
	'WScript.Echo creationDate
	
	Dim info
	Dim state
	info = "Check file: " & objFile.ShortPath & " -- " & objFile.DateCreated & " ---- " & Now

	If (Day(creationDate) = 1 And (Month(creationDate)=1 Or Month(creationDate)=4 Or Month(creationDate)=7 Or Month(creationDate)=10)) Then
		fileMustBeErase = False
		state = "4. each first day 1, 4, 7, 10 month of years"
	End If
	
	If ((Day(creationDate) = 1 Or Day(creationDate) = 15) And creationDate > DateAdd("m", -24, Now)) Then
		fileMustBeErase = False
		state = "3. each 1, 15 day of month for last 12 month"
	End If
	
	If ((Day(creationDate) = 1 Or Day(creationDate) = 8 Or Day(creationDate) = 15 Or Day(creationDate) = 22) And creationDate > DateAdd("ww", -20, Now)) Then
		fileMustBeErase = False
		state = "2. each 1, 8, 15, 22 day of month for last 20 week"
	End If
	
	If (creationDate > DateAdd("ww", -3, Now)) Then
		fileMustBeErase = False
		state = "1. last 3 week"
	End If
	
	If (creationDate > Now) Then
		fileMustBeErase = False
		state = "Skipped because in future"
	End If
	
	If fileMustBeErase Then
		state = "Need to clean"
	End If
	
	WScript.Echo info & " : " & state
	
	processFile = fileMustBeErase

End Function

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
			If (processFile(objFile) = True) Then
				objFSO.DeleteFile(objFile.Path)
			End If
		End If
	Next
	
End Sub

Call processFolder(".")
