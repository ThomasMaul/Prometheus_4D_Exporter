//%attributes = {"shared":true}
#DECLARE($para : Object)

$settings:=New object:C1471
$settings.HTTPPort:=9828
$settings.HTTPSPort:=9433
$settings.HTTPSEnabled:=False:C215

If (Count parameters:C259>0)
	If (String:C10($para.user)#"")
		Use (Storage:C1525)
			Storage:C1525.web:=New shared object:C1526("user"; String:C10($para.user); "pass"; String:C10($para.pass))
		End use 
	End if 
	If (Num:C11($para.HTTPPort)#0)
		$settings.HTTPPort:=$para.HTTPPort
	End if 
	If (Num:C11($para.HTTPSPort)#0)
		$settings.HTTPSPort:=$para.HTTPSPort
		$settings.HTTPSEnabled:=True:C214
	End if 
End if 

$webServer:=WEB Server:C1674(Web server database:K73:30)
$webServer.start($settings)