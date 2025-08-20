to_big = function(x) return x end
function Big:create(x, ...)
	return x
end
function to_number(x)
	if type(x) == 'table' and (getmetatable(x) == BigMeta or getmetatable(x) == OmegaMeta) then
	  return getmetatable(x) and getmetatable(x).__index.to_number(x) or 0
	else
	  return x
	end
end
Big = nil
local ref = SMODS.get_blind_amount
function SMODS.get_blind_amount(ante)
	local ret = ref(to_number(ante))
	if to_big(ret) > to_big(1e10) then return 0/0 end
	return ret
end

local gba = get_blind_amount
function get_blind_amount(ante)
	local ret = gba(to_number(ante))
	if to_big(ret) > to_big(1e10) then return 0/0 end
	return ret
end


function number_format(num)
	G.E_SWITCH_POINT = G.E_SWITCH_POINT or 100000000000
	if type(num) == "table" then return number_format(to_number(num)) end
	if not num or type(num) ~= 'number' then return num or '' end
	if num >= G.E_SWITCH_POINT then
	  local x = string.format("%.4g",num)
	  local fac = math.floor(math.log(tonumber(x), 10))
	  return string.format("%.3f",x/(10^fac))..'e'..fac
	end
	return string.format(num ~= math.floor(num) and (num >= 100 and "%.0f" or num >= 10 and "%.1f" or "%.2f") or "%.0f", num):reverse():gsub("(%d%d%d)", "%1,"):gsub(",$", ""):reverse()
end

local ref = SMODS.calculate_round_score
function SMODS.calculate_round_score(...)
	local score = ref(...)
	if to_big(score) > to_big(1e10) then return 10^400 end
	return score
end
