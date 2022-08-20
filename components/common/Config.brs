sub init()
  m.global.setField("config", Config())
end sub

function Config()
  return {
        "base_url": "http://xoe.ddns.net/",
        "api_key": "46270abd00c39663cde5d450ff83cbb8"
		}
end function
