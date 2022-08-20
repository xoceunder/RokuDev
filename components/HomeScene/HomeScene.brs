'********** Copyright 2016 Roku Corp.  All Rights Reserved. **********
'inits grid screen
'creates all children
'sets all observers
Function Init()
	Print "[HomeScene] Init"
	
	'GridScreen node with RowList
	m.GridScreen=m.top.findNode("GridScreen")
	m.GridScreen.Visible=FALSE

	'DetailsScreen Node with description, Video Player
	m.detailsScreen=m.top.findNode("DetailsScreen")
	
	'Observer to handle Item selection on RowList inside GridScreen (alias="GridScreen.rowItemSelected")
	m.top.observeField("rowItemSelected", "OnRowItemSelected")
	
	'loading indicator starts at initializatio of channel
	m.loadingIndicator=m.top.findNode("loadingIndicator")
	m.loadingIndicator.opacity=0
	
    m.global.addFields({"config": {}})
    m.global.unobserveField("config")
    m.config = CreateObject("RoSGNode", "Config")
	
	m.ParseGrid=m.top.findnode("ParseGrid")
	
	'Create main labellist menu
	m.MainMenu=m.top.findNode("MainMenuBackground")
	m.MainMenu.Visible=TRUE
	m.MainMenu.getChild(1).SetFocus(TRUE) 'Set focus to the list options
End Function

Function Moviescontentdownloaded()
	m.MainMenu.Visible=FALSE
	m.loadingIndicator.control="stop"
	m.loadingIndicator.opacity=0
	m.parsegrid.unobservefield("content")
	m.GridScreen.content=m.parsegrid.content
	m.GridScreen.visible="TRUE"
	m.GridScreen.SetFocus(TRUE)
End Function

Function MainMenuSelectionMade() 'interface for the main menu screen
Print m.MainMenu.getChild(1).itemselected.toStr()

	'first option is Movies Grid
	If m.MainMenu.getChild(1).itemSelected=0
		m.loadingIndicator.SetFocus(TRUE)
		m.loadingIndicator.control="start"
		m.loadingindicator.opacity=1
		m.ParseGrid.FunctionName="GetDataMovies"
		m.parsegrid.observefield("content","Moviescontentdownloaded")
		m.ParseGrid.control="RUN"
	End If
	
End Function

Function DismissDialog()
	m.top.dialog=invalid
End Function

'Row item selected handler interface for the grid content
Function OnRowItemSelected()
	'On select any item on home scene, show Details node and hide Grid
	m.gridScreen.visible="FALSE"
	m.detailsScreen.content=m.gridScreen.focusedContent
	m.detailsScreen.setFocus(TRUE)
	m.detailsScreen.visible="TRUE"
End Function

'Main Remote keypress event loop
Function OnKeyEvent(key, press) As Boolean
	Print ">>> HomeScene >> OnkeyEvent"
	result=FALSE
	If press
		If key="ok"
			Print"OK Pressed"
			'Print m.top.content.TITLE
			'Print m.itemfocused
			If m.top.dialog<>invalid m.top.dialog=invalid
			result=TRUE
		Else If key="options"
			m.dialog=CreateObject("roSGNode","Dialog")
			m.dialog.title="Settings"
			m.dialog.message="WOWOWOW"
			m.dialog.buttons=["First","Second"]
			m.dialog.optionsDialog=TRUE
			m.dialog.ObserveField("buttonSelected","DialogButtonSelected")
			result=TRUE
		Else If key="back"
			'exit channel if we're on the top selection screen and the user pressed back
			If m.MainMenu.Visible=TRUE
				result=FALSE
				
			'if Details opened
			Else If m.GridScreen.visible=FALSE And m.detailsScreen.videoPlayerVisible=FALSE
				m.GridScreen.visible=TRUE
				m.detailsScreen.visible=FALSE
				m.GridScreen.setFocus(TRUE)
				result=TRUE
				
			'if video player opened
			Else If m.GridScreen.visible=FALSE And m.detailsScreen.videoPlayerVisible=TRUE
				m.detailsScreen.videoPlayerVisible=FALSE
				result=TRUE

			'Exiting from Gridscreens to get back to the main selection menu
			Else If m.GridScreen.Visible=TRUE And m.MainMenu.Visible=FALSE
				m.GridScreen.Visible=FALSE
				m.MainMenu.Visible=TRUE
				m.MainMenu.getChild(1).SetFocus(TRUE)
				result=TRUE
			End If
		End If
	End If
	Return result
End Function
