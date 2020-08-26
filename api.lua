local api = {}
function save(filename)
	local fp = fs.open(filename, "w")
	fp.write("")
	fp.close()
	local fp = fs.open(filename, "a")
	for ln,l in pairs(TifImage) do
		for sn,s in pairs(TifImage[ln]) do
			fp.write(s)
		end
		if ln == #TifImage then
		break
		else
			fp.write("\n")
		end
	end
	fp.close()
end
local function drawPixel(x, y, PaintColor)
	    if TifImage       == nil or type(TifImage)   ~= "table" then
			local er = {true, "TifImage"}
		elseif x          == nil or type(x)          ~= "number" then
			local er = {true, "x"}
		elseif y          == nil or type(y)          ~= "number" then
			local er = {true, "y"}
		elseif PaintColor == nil or type(PaintColor) ~= "string" then
			local er = {true, "PaintColor"}
		else
			x = math.floor(x)
			y = math.floor(y)
			local er = {false}
			TifImage[y][x] = PaintColor
		end
		return er
    end
function drawImage(x, y, monitor) --return table{bool Error, string InvalidArgument}
	if type(monitor) ~= "table" then
		monitor = term
	end
	if TifImage == nil or type(TifImage) ~= "table" then
		local er = {true, "TifImage"}
	elseif x    == nil or type(x)        ~= "number" then
		local er = {true, "x"}
	elseif y    == nil or type(y)        ~= "number" then
		local er = {true, "y"}
	else
		local er = {false}
		for ln, l in pairs(TifImage) do
			for sn, s in pairs(TifImage[ln]) do
				local color = api.paintToDecimal(s)
				if color == nil then
					-- O_o
				else
					monitor.setBackgroundColor(color)
					monitor.setTextColor(color)
					monitor.setCursorPos(x+(sn-1), y+(ln-1))
					monitor.write("-")
				end
			end
		end
	end
	return er
end
function fill(w, h, PaintColor) --return table{bool Error, string InvalidArgument}
	if w          == nil or type(w)          ~= "number" then
		local er = {true, "w"}
	elseif h          == nil or type(h)          ~= "number" then
		local er = {true, "h"}
	elseif PaintColor == nil or type(PaintColor) ~= "string" then
		local er = {true, "PaintColor"}
	else
		w = math.floor(w)
		h = math.floor(h)
		local er = {false}
		TifImage = {}
		for i=1,h do
			s = {}
			for i=1,w do
				table.insert(s, PaintColor)
			end
			table.insert(TifImage, s)
		end
	end
	return er
end
function drawLine(startX, startY, endX, endY, PaintColor)
	if startX         == nil or type(startX)     ~= "number" then
		local er = {true, "startX"}
	elseif startY     == nil or type(startY)     ~= "number" then
		local er = {true, "startY"}
	elseif endX       == nil or type(endY)       ~= "number" then
		local er = {true, "endX"}
	elseif endY       == nil or type(endY)       ~= "number" then
		local er = {true, "endY"}
	elseif PaintColor == nil or type(PaintColor) ~= "string" then
		local er = {true, "PaintColor"}
	else
		startX = math.floor(startX)
	    startY = math.floor(startY)
	    endX = math.floor(endX)
	    endY = math.floor(endY)

	    if startX == endX and startY == endY then
	        drawPixel(startX, startY, PaintColor)
	    end
	    local minX = math.min(startX, endX)
	    local maxX, minY, maxY
	    if minX == startX then
	        minY = startY
	        maxX = endX
	        maxY = endY
	    else
	        minY = endY
	        maxX = startX
	        maxY = startY
	    end
	        
	    local xDiff = maxX - minX
	    local yDiff = maxY - minY
	            
	    if xDiff > math.abs(yDiff) then
	        local y = minY
	        local dy = yDiff / xDiff
	        for x=minX,maxX do
	            drawPixel(x, math.floor(y + 0.5), PaintColor)
	            y = y + dy
	        end
	    else
	        local x = minX
	        local dx = xDiff / yDiff
	        if maxY >= minY then
	            for y=minY,maxY do
	                drawPixel(math.floor(x + 0.5), y, PaintColor)
	            	x = x + dx
	            end
	        else
	            for y=minY,maxY,-1 do
	                drawPixel(math.floor(x + 0.5), y, PaintColor)
	                x = x - dx
	            end
	        end
	    end
	end
end
function drawBox(startX, startY, endX, endY, PaintColor, filled)
	if type(filled) ~= "boolean" or filled == false then
		filled = false
	end
	if startX         == nil or type(startX)     ~= "number" then
		local er = {true, "startX"}
	elseif startY     == nil or type(startY)     ~= "number" then
		local er = {true, "startY"}
	elseif endX       == nil or type(endY)       ~= "number" then
		local er = {true, "endX"}
	elseif endY       == nil or type(endY)       ~= "number" then
		local er = {true, "endY"}
	elseif PaintColor == nil or type(PaintColor) ~= "string" then
		local er = {true, "PaintColor"}
	else
		startX = math.floor(startX)
	    startY = math.floor(startY)
	    endX = math.floor(endX)
	    endY = math.floor(endY)
		local er = {false}
		if filled == false then
			drawLine(startX, startY, endX, startY, PaintColor)
			drawLine(startX, endY, endX, endY, PaintColor)
			drawLine(startX, startY, startX, endY, PaintColor)
			drawLine(endX, startY, endX, endY, PaintColor)
		else 
			for ln = startY, endY do
				drawLine(startX, ln, endX, ln, PaintColor)	
			end
		end
	end
	return er
end
local TifImageFunctions = {
	getImage = function() -- 
		return TifImage
	end,
	save = save,
	drawImage = drawImage,
	fill = fill,
	drawPixel = drawPixel,
	drawLine = drawLine,
	drawBox = drawBox
}
local bit32 = require("bit32")


function api.convertToPaint(decemical) --return string, nil
    return tostring(api.paintToDecimal(decemical))
end
function api.paintToDecimal(paint)
	if paint == nil then
		return nil
	else
		local number = tonumber(paint)
	    if not number then
			number = 10 + string.byte(paint) - 97
	    end
	    -- lua 5.3 return (2 << (number - 1))
		return bit32.lshift(2, number - 1)
	end
    
end
function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end
function api.loadImage(filename) --return table
	if fs.exists(filename) == nil then
		file = fs.open(filename, "w")
		file.write("")
		file.close()
	end
	local fp    = fs.open(filename, "r")
	local lines = split(fp.readAll(), "\n")
	for k,v in pairs(lines) do
		local splited = {}
		v:gsub(".",function(c) table.insert(splited,c) end)
		lines[k] = splited
	end
	TifImage = lines
	return TifImageFunctions
end
--[[
colors.white	 1	   0	#F0F0F0
colors.orange	 2	   1	#F2B233
colors.magenta	 4	   2	#E57FD8
colors.lightBlue 8	   3	#99B2F2
colors.yellow	 16	   4	#DEDE6C
colors.lime	     32	   5	#7FCC19
colors.pink	     64	   6	#F2B2CC
colors.gray	     128   7	#4C4C4C
colors.lightGray 256   8	#999999
colors.cyan	     512   9	#4C99B2
colors.purple	 1024  a	#B266E5
colors.blue	     2048  b	#3366CC
colors.brown	 4096  c	#7F664C
colors.green	 8192  d	#57A64E
colors.red	     16384 e	#CC4C4C
colors.black	 32768 f	#191919
]]--

return api
