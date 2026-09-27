Templates = {}

function lerp(a, b, t) return a + (b-a) * t end

function v3(coords) return vec3(coords.x, coords.y, coords.z), coords.w end

function GetRandomInt(min, max, exclude)
    for i=1, 1000 do 
        local int = math.random(min, max)
        if exclude == nil or exclude ~= int then 
            return int
        end
    end
end

function debugPrint(...)
    if Config.Debug then
        print(...)
    end
end

local function thousands_eu(n)
    n = math.floor(tonumber(n) or 0)
    local s = tostring(n)
    return s:reverse():gsub('(%d%d%d)','%1.'):reverse():gsub('^%.','')
end

function NumberWithCommas(x, noCurrency)
    return (not noCurrency and "€ " or "") .. thousands_eu(x or 0)
end

function tolower(str)
    return string.lower(str)
end

function GetItemLabel(name)
    return (Inventory.Items[name] and Inventory.Items[name].label or name)
end

function GetCurrencyString(amount)
    return NumberWithCommas(amount)
end