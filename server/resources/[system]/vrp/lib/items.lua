CreateThread(function()
    itemlist = exports["config"]:getItemList()
end)

itemList = function()
	return itemlist
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBODY
-----------------------------------------------------------------------------------------------------------------------------------------
itemBody = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
itemIndex = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["index"]
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMNAME
-----------------------------------------------------------------------------------------------------------------------------------------
itemName = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["name"]
	end

	return "Deletado"
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
itemType = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["type"]
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMMO
-----------------------------------------------------------------------------------------------------------------------------------------
itemAmmo = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["ammo"]
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
itemVehicle = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["vehicle"] or false
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
itemWeight = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["weight"] or 0.0
	end

	return 0.0
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMMAXAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
itemMaxAmount = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["max"] or nil
	end

	return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMSCAPE
-----------------------------------------------------------------------------------------------------------------------------------------
itemScape = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["scape"] or nil
	end

	return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDESCRIPTION
-----------------------------------------------------------------------------------------------------------------------------------------
itemDescription = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["desc"] or nil
	end

	return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMDURABILITY
-----------------------------------------------------------------------------------------------------------------------------------------
itemDurability = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["durability"] or false
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMCHARGES
-----------------------------------------------------------------------------------------------------------------------------------------
itemCharges = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["charges"] or nil
	end

	return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMECONOMY
-----------------------------------------------------------------------------------------------------------------------------------------
itemEconomy = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["economy"] or nil
	end

	return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMBLOCK
-----------------------------------------------------------------------------------------------------------------------------------------
itemBlock = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["block"] or nil
	end

	return nil
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMREPAIR
-----------------------------------------------------------------------------------------------------------------------------------------
itemRepair = function(Item)
	local Split = splitString(Item, "-")
	local Item = Split[1]

	if itemlist[Item] then
		return itemlist[Item]["repair"] or false
	end

	return false
end
