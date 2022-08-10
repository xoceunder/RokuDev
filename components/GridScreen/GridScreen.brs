' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********
'inits grid screen
'creates all children
'sets all observers

Function Init()
	Print"[GridScreen] Init"
	
	m.rowList=m.top.findNode("RowList")
	m.description=m.top.findNode("Description")
	m.background=m.top.findNode("Background")
	
	m.top.observeField("visible","onVisibleChange")
	m.top.observeField("focusedChild","OnFocusedChildChange")
End Function

'handler of focused item in RowList
Sub OnItemFocused()
	itemFocused=m.top.itemFocused
	
	'When an item gains the key focus, set to a 2-element array,
	'where element 0 contains the index of the focused row,
	'and element 1 contains the index of the focused item in that row.
	If itemFocused.Count()=2
		focusedContent=m.top.content.getChild(itemFocused[0]).getChild(itemFocused[1])
		If focusedContent<>invalid
			m.top.focusedContent=focusedContent
			m.description.content=focusedContent
			m.background.uri=focusedContent.hdBackgroundImageUrl
		End If
	End If
End Sub

'set proper focus to RowList in case if return from Details Screen
Sub onVisibleChange()
	If m.top.visible=TRUE
		m.rowList.setFocus(TRUE)
	End If
End Sub

'set proper focus to RowList in case if return from Details Screen
Sub OnFocusedChildChange()
	If m.top.isInFocusChain() And Not m.rowList.hasFocus()
		m.rowList.setFocus(TRUE)
	End If
End Sub
