--[[BOX WIDGET v1.0 by Wlourf 19/12/2010
This widget can drawn some boxes, even circles in your conky window
http://u-scripts.blogspot.com/ (HowTo coming soon)

Inspired by Background by londonali1010 (2009)

The parameters (all optionals) are :
x           - x coordinate of top-left corner of the box, default = 0 = (top-left corner of conky window)
y           - y coordinate of top-left corner of the box, default = 0 = (top-left corner of conky window)
w           - width of the box, default = width of the conky window
h           - height of the box, default = width of the conky window
radius      - radius of the corner, default = 0 = no radius
mode        - mode for drawing the radius, possible values are "circle" or "curve", default ="curve"
linear_gradient - table with the coordinates of two points to define a linear gradient,
                  points are relative to top-left corner of the box, (not the conky window)
                  {x1,y1,x2,y2}
radial_gradient - table with the coordinates of two circle to define a radial gradient,
             colour={{0,0xCCCCCC,1},{1,0xCCCCCC,0}}     points are relative to top-left corner of the box, (not the conky window)
                  {x1,y1,r1,x2,y2,r2} (r=radius)
colour      - table of colours, default = plain white {{1,0xFFFFFF,1}}
              this table contains one or more tables with format {P,C,A}
              P=position of gradient (0 = start of the gradient, 1= end of the gradient)
              C=hexadecimal colour 
              A=alpha (opacity) of color (0=invisible,1=opacity 100%)
              Examples :
              for a plain color {{1,0x00FF00,0.5}}
              for a gradient with two colours {{0,0x00FF00,0.5},{1,0x000033,1}}
              or {{0.5,0x00FF00,1},{1,0x000033,1}} -with this one, gradient will start in the middle
              for a gradient with three colours {{0,0x00FF00,0.5},{0.5,0x000033,1},{1,0x440033,1}}
              and so on ...



To call this script in Conky, use (assuming you have saved this script to ~/scripts/):
    lua_load ~/scripts/draw_bg.lua
    lua_draw_hook_pre main_box
    
And leave one line blank or not after TEXT

Changelog:
+ v1.0 -- Original release (19.12.2010)
]]

-- Change these settings to affect your background.

table_settings={
    {   
        x=5,
        y=57,
        h=40,
        w=650,
        linear_gradient = {300,200,550,350},
        colour = {{0,0x000000,0.5},{1,0x000000,0.5}},
        radius=20,
    },
    {   
        x=315,
        y=100,
        h=90,
        w=485,
        linear_gradient = {300,200,550,350},
        colour = {{0,0x000000,0.2},{1,0x000000,0.1}},
        radius=20,
    },
    {   
        x=5,
        y=192,
        h=44,
        w=795,
        linear_gradient = {300,200,550,350},
        colour = {{0,0x000000,0.4},{1,0x000000,0.1}},
        radius=20,
    },
    {   
        x=5,
        y=355,
        h=125,
        w=795,
        colour = {{0,0x000000,0.25}},
        radius=20,
     },
    {   
        x=5,
        y=240,
        h=110,
        w=795,
        colour = {{0,0x000000,0.4}},
        radius=20,
    },

--[[
    { --backgound with gradient
        radius=25,
        mode="circle",
        linear_gradient = {300,200,550,350},
        colour={{0,0xCCCCCC,1},{1,0xCCCCCC,0}}
    },




    { --pink rounded box
        x=25,
        y=150,
        h=200,
        w=100,
        colour = {{O,0xff00ff,0.5}},
        radius=30,
        mode="circle"
     }, 
    { --border for pink rounded box
        x=25,
        y=150,
        h=200,
        w=100,
        radius=30,
        border=3,
        mode="circle",
        colour={
                {0,0x0000CC,1},
                },    
         },
     
    {  --box with linear gradient
        x=150,
        y=150,
        h=100,
        w=100,
        linear_gradient = {50,0,50,100 },
        colour={
                    {0,0xffff00,1},
                    {0.5,0xff0000,1},                
                    {1,0xff00ff,1},
        },   
     },
     
     { --box with radial gradient
        x=150,
        y=270,
        h=100,
        w=100,
        radius=10,
        radial_gradient = {20,20,0,20,20,100 },
        colour={
                    {0,0xff0000,1},
                    {1,0xffff00,1},
                    },   
        mode="circle",
        border=0
     },
    { --border for above box --gradient are inversed
        x=150,
        y=270,
        h=100,
        w=100,
        radius=10,
        radial_gradient = {20,20,0,20,20,100 },
        colour={
                    {1,0xff0000,1},
                    {0,0xffff00,1},
                    },   
        mode="circle",
        border=5
     },


    { --oh my god, a circle with radial gradient
        x=300, y=30,
        w=100,h=100,
        mode="circle",
        radius=50,
        radial_gradient = {50,50,0,50,50,50 },        
        colour={
            {0,0xff0000,1},
            {1,0xffff00,1},
            },         
    },

    { --no name for this one ! radius > w or h !
        x=300, y=250,
        w=100,h=100,
        mode="circle",
        radius=100,
        radial_gradient = {50,50,0,50,50,50 },        
        colour={
            {0,0xff0000,1},
            {0.5,0x0000ff,1},            
            {1,0xffff00,1},
            }, 
    },
]]


  }

---------END OF PARAMETERS
    
require 'cairo'


    
function conky_main_box()
    if conky_window==nil then return end
    local cs=cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    cr=cairo_create(cs)
    
    for i in pairs(table_settings) do
        draw_bg (table_settings[i])
    end
    
    cairo_destroy(cr)
    cairo_surface_destroy(cs)    
end
    
function draw_bg(t)
    function rgba_to_r_g_b_a(tc)
        --tc={position,colour,alpha}
        local colour = tc[2]
        local alpha = tc[3]
        return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
    end

    local PI = math.pi

    --check values and set default values
    if t.x == nil then t.x = 0 end
    if t.y == nil then t.y = 0 end
    if t.w == nil then t.w = conky_window.width end
    if t.h == nil then t.h = conky_window.height end
    if t.radius == nil then t.radius = 0 end
    if t.border == nil then t.border = 0 end
    if t.colour==nil then t.colour={{1,0xFFFFFF,1}} end
    if t.linear_gradient ~= nil then 
        if #t.linear_gradient ~= 4 then
            t.linear_gradient = {t.x,t.y,t.width,t.height}
        end
    end 
    if t.radial_gradient ~= nil then 
        if #t.radial_gradient ~= 6 then
            t.radial_gradient = {t.x,t.y,0, t.x,t.y, t.width}
        end
    end 
    
    for i=1, #t.colour do    
        if #t.colour[i]~=3 then 
            print ("error in color table")
            t.colour[i]={1,0xFFFFFF,1} 
        end
    end

    --for better reading
    t.linear = t.linear_gradient
    t.radial = t.radial_gradient
    t.no_gradient = (t.linear == nil ) and (t.radial == nil )

    cairo_save(cr)
    cairo_translate(cr, t.x, t.y)

    if t.radius>0 then
        if t.mode=="circle" then
            cairo_arc(cr, t.radius, t.radius, t.radius, -PI, -PI/2)
            cairo_line_to(cr,t.w-t.radius,0)
            cairo_arc(cr, t.w-t.radius, t.radius, t.radius, -PI/2,0)
            cairo_line_to(cr,t.w,t.h-t.radius)
            cairo_arc(cr, t.w-t.radius, t.h-t.radius, t.radius, 0,PI/2)
            cairo_line_to(cr,t.radius,t.h)
            cairo_arc(cr, t.radius, t.h-t.radius, t.radius, PI/2,-PI)        
            cairo_line_to(cr,0,t.radius) 
        else
            cairo_move_to(cr,   t.radius,     0)
            cairo_line_to(cr,   t.w-t.radius, 0)
            cairo_curve_to(cr,  t.w,    0,  t.w,    0,  t.w,    t.radius)
            cairo_line_to(cr,   t.w,    t.h-t.radius)
            cairo_curve_to(cr,  t.w,    t.h,    t.w,    t.h,    t.w -   t.radius, t.h)
            cairo_line_to(cr,   t.radius, t.h)
            cairo_curve_to(cr,  0,  t.h,    0,  t.h,    0,  t.h-t.radius)
            cairo_line_to(cr,   0,  t.radius)
            cairo_curve_to(cr,  0,  0,  0,  0,  t.radius,0)
        end
        cairo_close_path(cr)
    else
        cairo_rectangle(cr,0,0,t.w,t.h)
    end
    
    if t.no_gradient then
        cairo_set_source_rgba(cr,rgba_to_r_g_b_a(t.colour[1]))
    else
        if t.linear ~= nil then
            pat = cairo_pattern_create_linear (t.linear[1],t.linear[2],t.linear[3],t.linear[4])
        elseif t.radial ~= nil then
            pat = cairo_pattern_create_radial (t.radial[1],t.radial[2],t.radial[3],t.radial[4],t.radial[5],t.radial[6])
        end
        for i=1, #t.colour do
            cairo_pattern_add_color_stop_rgba (pat, t.colour[i][1], rgba_to_r_g_b_a(t.colour[i]))
        end
        cairo_set_source (cr, pat)
        cairo_pattern_destroy(pat)
    end
    
    if t.border>0 then
        cairo_set_line_width(cr,t.border)
        cairo_stroke(cr)
    else
        cairo_fill(cr)
    end
    
    cairo_restore(cr)
end

