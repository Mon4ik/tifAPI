api = {}
function api.convertToPaint(Decimal) --return number, string, nil
	local result = nil
	if Decimal      == 1          then
		result =  0
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
return api