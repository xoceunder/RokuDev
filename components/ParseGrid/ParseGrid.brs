Function init()
End Function

Function GetDataMovies()

	jsonAsString = ReadAsciiFile("pkg:/json/feed-v1.json")
	responseJSON = ParseJSON(jsonAsString)
	
	content=[]
	CategoryNames=[]
	numofcategories=responseJSON.Count()-1
	For c=0 To numofcategories
	    print
		CategoryNames.Push(responseJSON[c].category )
		temparray=[]
		if responseJSON[c].items <> invalid
		For x=0 To responseJSON[c].items.Count()-1
			itemAA=responseJSON[c].items[x]
		   	item={}
		    item=itemAA
			temparray.Push(item)
		Next
		end if
		content.Push(temparray)
	Next
	
	RowItems=createObject("RoSGNode","ContentNode")
	
	For x=0 To CategoryNames.Count()-1
		row=createObject("RoSGNode","ContentNode")
		row.Title=CategoryNames[x]
		if content[x] <> invalid
		For Each itemAA In content[x]
		    'print itemAA
			item=createObject("RoSGNode","ContentNode")
			item.Title=itemAA.Title
			item.ContentType=itemAA.ContentType
			item.ContentId=itemAA.MoviesId
			item.Id=itemAA.MoviesId
			item.description=itemAA.description
			item.url=itemAA.StreamUrls
			item.Rating=itemAA.Rating
			item.SubtitleUrl=itemAA.SubtitleUrl
			item.Length=itemAA.Length
			item.streamFormat=itemAA.StreamFormat
			item.releasedate=itemAA.ReleaseDate
			item.HDPosterURL=itemaa.SDPosterUrl
			item.hdbackgroundimageurl=itemaa.HDPosterURL
			row.AppendChild(item) 'Add each individual item
		Next
		end if
		RowItems.AppendChild(row) 'Add each individual category of items
	Next
	m.top.content=RowItems 'set top content field to the entire screen's content which will cause the content observer to notice
End Function