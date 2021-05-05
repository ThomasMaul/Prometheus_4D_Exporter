C_TEXT:C284($1; $2; $3; $4; $5; $6)

If ($1="/Metrics")
	C_BLOB:C604($blobin; $blobout)
	DOCUMENT TO BLOB:C525(Get 4D folder:C485(Current resources folder:K5:16)+"metrics.shtml"; $blobin)
	PROCESS 4D TAGS:C816($blobin; $blobout)
	WEB SEND BLOB:C654($blobout; "text/plain")
End if 