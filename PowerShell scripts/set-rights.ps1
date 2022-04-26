
function SetAccess{
	param (
		$FolderName,
		$UserName,
		$Debug
	)
	
	$ACL = Get-Acl -Path $FolderName
	if ($Debug) {
		Write-Host "--- start add access"
		foreach( $s in $ACL.Access){
			Write-Host $s.IdentityReference
		}
	}
	$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($UserName, "FullControl", ("ContainerInherit","ObjectInherit"), "None", "Allow")
	$ACL.SetAccessRule($AccessRule)
	$ACL | Set-Acl -Path $FolderName
	if ($Debug) {
		Write-Host "--- afrer adding"
		foreach( $s in $ACL.Access){
			Write-Host $s.IdentityReference
		}
	}
	
	$ACL.SetAccessRuleProtection($true, $false)
	$ACL | Set-Acl -Path $FolderName
	if ($Debug) {
		Write-Host "--- afrer uninherite"
		foreach( $s in $ACL.Access){
			Write-Host $s.IdentityReference
		}
	}
	
	#$AccessRuleBreake = New-Object System.Security.AccessControl.FileSystemAccessRule("Пользователи домена", ("ReadAndExecute", "Synchronize"), ("ContainerInherit","ObjectInherit"), "None", "Allow")
	$AccessRuleBreake = New-Object System.Security.Principal.NTAccount("Пользователи домена")
	#Write-Host $AccessRuleBreake
	#$ACL.RemoveAccessRule($AccessRuleBreake)
	$ACL.PurgeAccessRules($AccessRuleBreake)
	$ACL | Set-Acl -Path $FolderName
	if ($Debug) {
		$ACL = Get-Acl -Path $FolderName
		Write-Host "--- afrer removing"
		foreach( $s in $ACL.Access){
			Write-Host $s.IdentityReference
		}
	}
}



foreach ($file in Get-ChildItem){
	$search = -join('Name -like "*', $file.Name, '"')
	$folder = -join("c:\Share\", $file.Name)
	$user = Get-ADUser -Filter $search
	#if ($user.Name -eq "Владислав Зеленков") {
	#}else{
	#	continue
	#}
	if ($user) {
		SetAccess -FolderName $folder -UserName $user.SamAccountName -Debug $false
		$text = -join("User ", $user.SamAccountName, " set rights to folder: ", $folder )
		Write-Host $text
	}
}
