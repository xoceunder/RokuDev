' ********** Copyright 2015 Roku Corp.  All Rights Reserved. **********

Sub RunUserInterface()
	screen=CreateObject("roSGScreen")
	scene=screen.CreateScene("HomeScene")
	port=CreateObject("roMessagePort")
	screen.SetMessagePort(port)
	screen.Show()
	
	While TRUE
		msg=Wait(0,port)
		print"------------------"
		Print"msg=";msg
	End While
	
	If screen<>invalid
		screen.Close()
		screen=invalid
	End If
End Sub
