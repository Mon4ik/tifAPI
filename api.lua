api = {}
function api.convertToPaint(Decimal) --return number, string, nil
	local result = nil
	if Decimal      == 1          then
		result = "0"
	elseif Decimal  == 2          then
		result = "1"
	elseif Decimal  == 4          then
		result = "2"
	elseif Decimal  == 8          then
		result = "3"
	elseif Decimal  == 16         then
		result = "4"
	elseif Decimal  == 32         then
		result = "5"
	elseif Decimal  == 64         then
		result = "6"
	elseif Decimal  == 128        then
		result = "7"
	elseif Decimal  == 256        then
		result = "8"
	elseif Decimal  == 512        then
		result = "9"
	elseif Decimal  == 1024       then -- Now simbols
		result = "a"
	elseif Decimal  == 2048       then
		result = "b"
	elseif Decimal  == 4096       then
		result = "c"
	elseif Decimal  == 8192       then
		result = "d"
	elseif Decimal  == 16384      then
		result = "e"
	elseif Decimal  == 32768      then
		result = "f"
	end
	return result
end
function api.paintToDecimal(Paint)
	local result = nil
	if Paint     == "0" then
		result = 1
	elseif Paint == "1" then
		result = 2
	elseif Paint == "2" then
		result = 4
	elseif Paint == "3" then
		result = 8
	elseif Paint == "4" then
		result = 16
	elseif Paint == "5" then
		result = 32
	elseif Paint == "6" then
		result = 64
	elseif Paint == "7" then
		result = 128
	elseif Paint == "8" then
		result = 256
	elseif Paint == "9" then
		result = 512
	elseif Paint == "a" then
		result = 1024
	elseif Paint == "b" then
		result = 2048
	elseif Paint == "c" then
		result = 4096
	elseif Paint == "d" then
		result = 8192
	elseif Paint == "e" then
		result = 16384
	elseif Paint == "f" then
		result = 32768
	else end
	return result
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
