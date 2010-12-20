do
	package.path = "/home/user/MyDocs/lua/?.lua" --loads all lua files from here
	require 'text' --specify each one we really want again like this, text = text.lua
	require 'graph'
	require 'bargraph_eng'
	require 'misc'
	require 'luatraverse'
	require 'strict'

	--local count
	
	function conky_main() --conky will run this if you specified to load 'main' in the conf
		conky_main_bars()
		conky_main_graph()
		conky_draw_text()
		--collectgarbage(collect)
		--local y = traverse.countreferences(deleteme)
		--print (tostring(y))
		--count = #(_G)
		--local run = true
		--io.output("/home/user/MyDocs/lua/lua.log")
		--for n,v in pairs(_G) do
		--	io.write (tostring(n)," ",tostring(v),"\n")
		--end
		--io.write (tostring(count))
		--print (count)
	end
end