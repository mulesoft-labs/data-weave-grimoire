%dw 2.0
import * from dw::io::http::Client
output json
var URL = "https://api.github.com/search/repositories?q=-data-weave-grimoire"
var body = request("GET", URL).body
var wizardNames = body.items.owner.login distinctBy $
---
{
	total_count: sizeOf(wizardNames),
	names: wizardNames
}