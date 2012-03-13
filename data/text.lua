--[[TEXT WIDGET v1.. by Wlourf 25/06/2010
This widget can drawn texts set in the "text_settings" table with some parameters
http://u-scripts.blogspot.com/2010/06/text-widget.html

The parameters (all optionals) are :
text        - text to display, default = "Conky is good for you"
			  use conky_parse to display conky value ie text=conly_parse("${cpu cpu1}")
            - coordinates below are relative to top left corner of the conky window
x           - x coordinate of first letter (bottom-left), default = center of conky window
y           - y coordinate of first letter (bottom-left), default = center of conky window
h_align		- horizontal alignement of text relative to point (x,y), default="l"
			  available values are "l": left, "c" : center, "r" : right
v_align		- vertical alignment of text relative to point (x,y), default="b"
			  available values "t" : top, "m" : middle, "b" : bottom
font_name   - name of font to use, default = Free Sans
font_size   - size of font to use, default = 14
italic      - display text in italic (true/false), default=false
oblique     - display text in oblique (true/false), default=false (I don' see the difference with italic!)
bold        - display text in bold (true/false), default=false
angle       - rotation of text in degrees, default = 0 (horizontal)
colour      - table of colours for text, default = plain white {{1,0xFFFFFF,1}}
			  this table contains one or more tables with format {P,C,A}
              P=position of gradient (0 = beginning of text, 1= end of text)
              C=hexadecimal colour 
              A=alpha (opacity) of color (0=invisible,1=opacity 100%)
              Examples :
              for a plain color {{1,0x00FF00,0.5}}
              for a gradient with two colours {{0,0x00FF00,0.5},{1,0x000033,1}}
              or {{0.5,0x00FF00,1},{1,0x000033,1}} -with this one, gradient will start in the middle of the text
              for a gradient with three colours {{0,0x00FF00,0.5},{0.5,0x000033,1},{1,0x440033,1}}
			  and so on ...
orientation	- in case of gradient, "orientation" defines the starting point of the gradient, default="ww"
			  there are 8 available starting points : "nw","nn","ne","ee","se","ss","sw","ww"
			  (n for north, w for west ...)
			  theses 8 points are the 4 corners + the 4 middles of text's outline
			  so a gradient "nn" will go from "nn" to "ss" (top to bottom, parallele to text)
			  a gradient "nw" will go from "nw" to "se" (left-top corner to right-bottom corner)
radial		- define a radial gradient (if present at the same time as "orientation", "orientation" will have no effect)
			  this parameter is a table with 6 numbers : {xa,ya,ra,xb,yb,rb}
			  they define two circle for the gradient :
			  xa, ya, xb and yb are relative to x and y values above
reflection_alpha    - add a reflection effect (values from 0 to 1) default = 0 = no reflection
                      other values = starting opacity
reflection_scale    - scale of the reflection (default = 1 = height of text)
reflection_length   - length of reflection, define where the opacity will be set to zero
					  calues from 0 to 1, default =1
skew_x,skew_y    - skew text around x or y axis
			  

Needs conky 1.8.0 

To call this script in the conkyrc, in before-TEXT section:
    lua_load /path/to/the/lua/script/text.lua
    lua_draw_hook_pre draw_text
 
v1.0	07/06/2010, Original release
v1.1	10/06/2010	Add "orientation" parameter
v1.2	15/06/2010  Add "h_align", "v_align" and "radial" parameters
v1.3	25/06/2010  Add "reflection_alpha", "reflection_length", "reflection_scale", 
                    "skew_x" et "skew_y"


]]

require 'cairo'

function conky_draw_text()
	local col0,col1,col2=0xFFFFCC,0xCCFF99,0x99FF00
	local colbg=0x99CCFF
    local text_settings={
    		{
				text=conky_parse("${time %I:%M%p %D}"),
				font_size=24,
				bold=true,
				font_name="Nokia Pure",
				h_align="l",
				v_align="t",
				x=5,
				y=5,
				reflection_alpha=0,
				reflection_length=0,
 colour={
         {0.98,    0xFF0000,1},
         {0.99,    0xFFCC00,1},
         {1.00,    0xFF0000,1},
         },
 radial={400,-700,0,100,-1000,1024}
		}, 
		{
				text=conky_parse("$sysname $kernel on $machine - $uptime"),
				font_size=16,
				bold=true,
				font_name="Nokia Pure",
				h_align="r",
				x=850,
				y=15,
				reflection_alpha=0,
				reflection_length=0,
				colour={{0,col0,0.75},{1,colbg,0.75}},

		}, 
		{
				text=conky_parse("$freq MHz"),
				font_name="Nokia Pure",
				font_size=16,
				h_align="l",
				v_align="t",
				bold=true,
				x=20,
				y=60,
				reflection_alpha=0,
				reflection_length=0,
				colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
		},
		{
		    text=conky_parse("${battery_temp}").."\194\176",--yes i had to do the degree symbol like that...
                    x=845,
		    y=69,
		    v_align="m",
		    h_align="r",
		    font_name="Nokia Pure",
		    font_size=14,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
    		reflection_alpha=0,
    		reflection_length=0,			
        },
		{
		    text=conky_parse("${battery_rate}mA"),
                    x=750,
		    y=69,
		    v_align="m",
		    h_align="l",
		    font_name="Nokia Pure",
		    font_size=14,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
    		reflection_alpha=0,
    		reflection_length=0,			
        },
       	{
		    text=conky_parse("${battery_short}   ${battery_volts}mV"),
                    x=845,
		    y=45,
		    v_align="m",
		    h_align="r",
		    font_name="Nokia Pure",
		    font_size=14,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
    		reflection_alpha=0,
    		reflection_length=0,			
        }, 
       	{
		    text=conky_parse("${cell_radio_dbm}".."dBm"),
	  		x=510,
		    y=50,
		    font_name="Nokia Pure",
		    font_size=14,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
    		reflection_alpha=0.0,
    		reflection_length=0.0,			
        },
        {
		    text=conky_parse('${cpu}').."%",
		  	x=223,
		    y=67,
		    v_align="t",
		    h_align="l",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="ww",
    		reflection_alpha=0,
    		reflection_length=0,			
        },  
        {
		    text=conky_parse('${memperc}').."% RAM",
		    x=223,
		    y=101,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
				reflection_alpha=0,
				reflection_length=0,
        },
        {
		    text=conky_parse('${fs_used /} / ${fs_size /} (${fs_free /})'),
		    x=5,
		    y=125,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=16,
		   	colour={{conky_parse('${fs_used_perc /}')/100,0x000000,1},{1,0xFFFFFF,1}},
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
        },
        {
		    text="/",
		    x=220,
		    y=124,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,0x336633,1},{1,col0,1}},
		   	bold=true,
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
        },
        {
		    text=conky_parse('${fs_used /home} / ${fs_size /home} (${fs_free /home})'),
		    x=5,
		    y=145,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=16,
		   	colour={{conky_parse('${fs_used_perc /home}')/100,0x000000,1},{1,0xFFFFFF,1}},
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
        },
        {
		    text="/home",
		    x=220,
		    y=144,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,0x336633,1},{1,col0,1}},
		   	bold=true,
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
        },
        {
		    text=conky_parse('${fs_used /home/user/MyDocs} / ${fs_size /home/user/MyDocs} (${fs_free /home/user/MyDocs})'),
		    x=5,
		    y=165,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=16,
		   	colour={{conky_parse('${fs_used_perc /home/user/MyDocs}')/100-.1,0x000000,1},{1,0xFFFFFF,1}},
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
				DrawMe=conky_parse("${if_mounted /home/user/MyDocs}1$endif")
        },
        {
		    text="MyDocs",
		    x=220,
		    y=164,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,0x336633,1},{1,col0,1}},
		   	bold=true,
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
				DrawMe=conky_parse("${if_mounted /home/user/MyDocs}1$endif")
        },        
        {
		    text="DiskIO",
		    x=520,
		    y=101,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,0xcc6600,1},{1,col0,1}},
		   	bold=true,
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
        },
        {
		    text="Charge Rate",
		    x=720,
		    y=101,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,0xFF0000,1},{1,col0,1}},
		   	bold=true,
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
        },
        
 --[[   {
		    text=conky_parse('${fs_used /media/mmc1} / ${fs_size /media/mmc1} (${fs_free /media/mmc1})'),
		    x=5,
		    y=175,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=16,
		   	colour={{conky_parse('${fs_used_perc /media/mmc1}')/100-.1,0x000000,1},{1,0xFFFFFF,1}},
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
				DrawMe=conky_parse("${if_mounted /media/mmc1}1$endif")
        },
        {
		    text="SDCard",
		    x=220,
		    y=174,
		    v_align="t",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,0x336633,1},{1,col0,1}},
		   	bold=true,
				orientation="ww",
				reflection_alpha=0,
				reflection_length=0,
				DrawMe=conky_parse("${if_mounted /media/mmc1}1$endif"),
        },
		]]
        {
		    text=conky_parse('${wireless_essid wlan0}'),
	  		x=427,
		    y=202,
		    h_align="c",
		    v_align="m",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
    		reflection_alpha=0,
    		reflection_length=0,
    		DrawMe=conky_parse("${if_up wlan0}1${else}0$endif"),
        },
        {
		    text="GPRS",
	  		x=427,
		    y=201,
		    h_align="c",
		    v_align="m",
		    font_name="Nokia Pure",
		    font_size=18,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
    		reflection_alpha=0,
    		reflection_length=0,
    		DrawMe=conky_parse("${if_up gprs0}1${else}0$endif"),
        },
        {
		    text=conky_parse('${wireless_link_qual_perc wlan0}')..'%',
	  		x=427,
		    y=226,
		    h_align="c",
		    v_align="m",
		    font_name="Nokia Pure",
		    font_size=14,
		   	colour={{0,col0,1},{0.5,colbg,1}},
				orientation="nn",
    		reflection_alpha=0,
    		reflection_length=0,
    		DrawMe=conky_parse("${if_up wlan0}1${else}0$endif"),
        },
        {
		    text='Up '..conky_parse('${upspeedf wlan0}') + conky_parse('${upspeedf gprs0}'),
	  		x=225,
		    y=223,
		    h_align="l",
		    v_align="m",
		    font_name="LEDFont",
		    font_size=22,
		    bold=true,
		   	colour={{0,0xcc0066,1}},
				orientation="ww",
    		reflection_alpha=0,
    		reflection_length=0,
    		DrawMe=conky_parse("${if_up wlan0}1${else}0$endif"),
        },
        {
		    text=conky_parse('${downspeedf wlan0}') + conky_parse('${downspeedf gprs0}')..' Down',
	  		x=650,
		    y=223,
		    h_align="r",
		    v_align="m",
		    font_name="LEDFont",
		    font_size=22,
		    bold=true,
		   	colour={{0,0xcc0066,1}},
				orientation="ww",
    		reflection_alpha=0,
    		reflection_length=0,
    		DrawMe=conky_parse("${if_up wlan0}1${else}0$endif"),
        },
   --[[     {
		    text='Up '..conky_parse('${upspeed gprs0}'),
	  		x=225,
		    y=223,
		    h_align="l",
		    v_align="m",
		    font_name="LEDFont",
		    font_size=22,
		    bold=true,
		   	colour={{0,0xcc0066,1}},
				orientation="ww",
    		reflection_alpha=0,
    		reflection_length=0,
    		DrawMe=conky_parse("${if_up gprs0}1${else}0$endif"),
        },
        {
		    text=conky_parse('${downspeed gprs0}')..' Down',
	  		x=650,
		    y=223,
		    h_align="r",
		    v_align="m",
		    font_name="LEDFont",
		    font_size=22,
		    bold=true,
		   	colour={{0,0xcc0066,1}},
				orientation="ww",
    		reflection_alpha=0,
    		reflection_length=0,
    		DrawMe=conky_parse("${if_up gprs0}1${else}0$endif"),
        },]]  
    }
    if conky_window == nil then return end
    if tonumber(conky_parse("$updates"))<3 then return end
	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    for i,v in pairs(text_settings) do	
    	cr = cairo_create (cs)
			display_text(v)
	    cairo_destroy(cr)
	    cr = nil
    end
	cairo_surface_destroy(cs)
end

function rgb_to_r_g_b2(tcolour)
    local colour,alpha=tcolour[2],tcolour[3]
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function display_text(t)
	if t.DrawMe~=nil and t.DrawMe ~= "1" then return end
	local function set_pattern(te)
		--this function set the pattern
		if #t.colour==1 then 
		    cairo_set_source_rgba(cr,rgb_to_r_g_b2(t.colour[1]))
		else
			local pat
			if t.radial==nil then
				local pts=linear_orientation(t,te)
				pat = cairo_pattern_create_linear (pts[1],pts[2],pts[3],pts[4])
			else
				pat = cairo_pattern_create_radial (t.radial[1],t.radial[2],t.radial[3],t.radial[4],t.radial[5],t.radial[6])
			end
		    for i=1, #t.colour do
		        cairo_pattern_add_color_stop_rgba (pat, t.colour[i][1], rgb_to_r_g_b2(t.colour[i]))
		    end
		    cairo_set_source (cr, pat)
			cairo_pattern_destroy(pat)
		end
    end
    
    --set default values if needed
    if t.text==nil then t.text="Conky is good for you !" end
    if t.x==nil then t.x = conky_window.width/2 end
    if t.y==nil then t.y = conky_window.height/2 end
    if t.colour==nil then t.colour={{1,0xFFFFFF,1}} end
    if t.font_name==nil then t.font_name="Free Sans" end
    if t.font_size==nil then t.font_size=14 end
    if t.angle==nil then t.angle=0 end
    if t.italic==nil then t.italic=false end
    if t.oblique==nil then t.oblique=false end
    if t.bold==nil then t.bold=false end
    if t.radial ~= nil then
    	if #t.radial~=6 then 
    		print ("error in radial table")
    		t.radial=nil 
    	end
    end
    if t.orientation==nil then t.orientation="ww" end
    if t.h_align==nil then t.h_align="l" end
    if t.v_align==nil then t.v_align="b" end    
    if t.reflection_alpha == nil then t.reflection_alpha=0 end
    if t.reflection_length == nil then t.reflection_length=1 end
    if t.reflection_scale == nil then t.reflection_scale=1 end
    if t.rotx==nil then t.rotx=0 end
    if t.roty==nil then t.roty=0 end    
    cairo_translate(cr,t.x,t.y)
    cairo_rotate(cr,t.angle*math.pi/180)
    cairo_save(cr)       
    local slant = CAIRO_FONT_SLANT_NORMAL
    local weight = CAIRO_FONT_WEIGHT_NORMAL
    if t.italic then slant = CAIRO_FONT_SLANT_ITALIC end
    if t.oblique then slant = CAIRO_FONT_SLANT_OBLIQUE end
    if t.bold then weight = CAIRO_FONT_WEIGHT_BOLD end
    cairo_select_font_face(cr, t.font_name, slant,weight)
    for i=1, #t.colour do    
        if #t.colour[i]~=3 then 
        	print ("error in color table")
        	t.colour[i]={1,0xFFFFFF,1} 
        end
    end
	local matrix0 = cairo_matrix_t:create()
	tolua.takeownership(matrix0) 
	local rotx,roty=t.rotx/t.font_size,t.roty/t.font_size
	cairo_matrix_init (matrix0, 1,roty,rotx,1,0,0)
	cairo_transform(cr,matrix0)
	cairo_set_font_size(cr,t.font_size)
	local te=cairo_text_extents_t:create()
	tolua.takeownership(te) 
    cairo_text_extents (cr,t.text,te)
	set_pattern(te)
    local mx,my=0,0
    if t.h_align=="c" then
	    mx=-te.width/2
    elseif t.h_align=="r" then
	    mx=-te.width
	end
    if t.v_align=="m" then
	    my=-te.height/2-te.y_bearing
    elseif t.v_align=="t" then
	    my=-te.y_bearing
	end
	cairo_move_to(cr,mx,my)
    cairo_show_text(cr,t.text)
		
   if t.reflection_alpha ~= 0 then 
		local matrix1 = cairo_matrix_t:create()
		tolua.takeownership(matrix1) 
		cairo_set_font_size(cr,t.font_size)
		cairo_matrix_init (matrix1,1,0,0,-1*t.reflection_scale,0,(te.height+te.y_bearing+my)*(1+t.reflection_scale))
		cairo_set_font_size(cr,t.font_size)
		te=nil
		local te=cairo_text_extents_t:create()
		tolua.takeownership(te) 
		cairo_text_extents (cr,t.text,te)		
		cairo_transform(cr,matrix1)
		set_pattern(te)
		cairo_move_to(cr,mx,my)
		cairo_show_text(cr,t.text)
		local pat2 = cairo_pattern_create_linear (0,
										(te.y_bearing+te.height+my),
										0,
										te.y_bearing+my)
		cairo_pattern_add_color_stop_rgba (pat2, 0,1,0,0,1-t.reflection_alpha)
		cairo_pattern_add_color_stop_rgba (pat2, t.reflection_length,0,0,0,1)	
		cairo_set_line_width(cr,0)
		local dy=te.x_bearing
		if dy<0 then dy=dy*(-1) end
		cairo_rectangle(cr,mx+te.x_bearing,te.y_bearing+te.height+my,te.width+dy,-te.height*1.05)
		cairo_clip_preserve(cr)
		cairo_set_operator(cr,CAIRO_OPERATOR_CLEAR)
		--cairo_stroke(cr)
		cairo_mask(cr,pat2)
		cairo_pattern_destroy(pat2)
		cairo_set_operator(cr,CAIRO_OPERATOR_OVER)
		te=nil
    end
end


 function linear_orientation(t,te)
	local w,h=te.width,te.height
	local xb,yb=te.x_bearing,te.y_bearing
	
    if t.h_align=="c" then
	    xb=xb-w/2
    elseif t.h_align=="r" then
	    xb=xb-w
   	end	
    if t.v_align=="m" then
	    yb=-h/2
    elseif t.v_align=="t" then
	    yb=0
   	end	
   	local p=0
	if t.orientation=="nn" then
		p={xb+w/2,yb,xb+w/2,yb+h}
	elseif t.orientation=="ne" then
		p={xb+w,yb,xb,yb+h}
	elseif t.orientation=="ww" then
		p={xb,h/2,xb+w,h/2}
	elseif vorientation=="se" then
		p={xb+w,yb+h,xb,yb}
	elseif t.orientation=="ss" then
		p={xb+w/2,yb+h,xb+w/2,yb}
	elseif vorientation=="ee" then
		p={xb+w,h/2,xb,h/2}		
	elseif t.orientation=="sw" then
		p={xb,yb+h,xb+w,yb}
	elseif t.orientation=="nw" then
		p={xb,yb,xb+w,yb+h}
	end
	return p
end

