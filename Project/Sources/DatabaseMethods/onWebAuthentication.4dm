C_TEXT:C284($1; $2; $3; $4; $5; $6)
C_BOOLEAN:C305($0)
$user:=$5
$pass:=$6

$0:=False:C215
If (String:C10(Storage:C1525.web.user)="")
	$0:=True:C214
Else 
	If (Compare strings:C1756($user; Storage:C1525.web.user; sk case insensitive:K86:6)=0)
		If (Compare strings:C1756($pass; Storage:C1525.web.pass; sk strict:K86:4)=0)
			$0:=True:C214
		End if 
	End if 
End if 
