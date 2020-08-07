local api = {}


local bit32 = require("bit32")


function api.convertToPaint(decemical) --return number, string, nil
    return tostring(api.paintToDecimal(decemical))
end
function api.paintToDecimal(paint)
    local number = tonumber(paint)
    if not number then
		number = 10 + string.byte(paint) - 97
    end

    -- lua 5.3 return (2 << (number - 1))
	return bit32.lshift(2, number - 1)
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
	local fp    = fs.open(filename, "r")
	local lines = split(fp.readAll(), "\n")
	for k,v in pairs(lines) do
		local splited = {}
		v:gsub(".",function(c) table.insert(splited,c) end)
		lines[k] = splited
	end
	return lines
end
function api.saveImage(TifImage, filename)
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
function api.drawImage(TifImage, x, y, monitor)
	if type(monitor) ~= "table" then
		monitor = term
	end
	if TifImage == nil or type(TifImage) ~= "table" then
		error("Invalid argument TifImage!")
	elseif x    == nil or type(x)        ~= "number" then
		error("Invalid argument x!")
	elseif y    == nil or type(y)        ~= "number" then
		error("Invalid argument y!")
	else
		for ln, l in pairs(TifImage) do
			for sn, s in pairs(TifImage[ln]) do
				local color = api.paintToDecimal(s)
				monitor.setBackgroundColor(color)
				monitor.setTextColor(color)
				monitor.setCursorPos(x+(sn-1), y+(ln-1))
				monitor.write("-")
			end
		end
	end
end
function api.fillImage(w, h, PaintColor)
	if w          == nil or type(w)          ~= "number" then
		error("Invalid argument w!")
	elseif h          == nil or type(h)          ~= "number" then
		error("Invalid argument h!")
	elseif PaintColor == nil or type(PaintColor) ~= "string" then
		error("Invalid argument PaintColor!")
	else
		TifImage = {}
		for i=1,h do
			s = {}
			for i=1,w do
				table.insert(s, PaintColor)
			end
			table.insert(TifImage, s)
		end
		return TifImage

	end
end
function api.drawPixel(TifImage, x, y, PaintColor)
	if TifImage       == nil or type(TifImage)   ~= "table" then
		error("Invalid argument TifImage!")
	elseif x          == nil or type(x)          ~= "number" then
		error("Invalid argument w!")
	elseif y          == nil or type(y)          ~= "number" then
		error("Invalid argument h!")
	elseif PaintColor == nil or type(PaintColor) ~= "string" then
		error("Invalid argument PaintColor!")
	else
		if TifImage[y][x] == nil then
			error("You can draw only on any color.")
		else
			TifImage[y][x] = PaintColor
			return TifImage
		end
	end
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
