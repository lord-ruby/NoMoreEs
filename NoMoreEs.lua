to_big = to_big or function(x) return x end
to_number = to_number or function(x) return x end

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

if Entropy then
	local chipmultref = Entropy.get_chipmult_score
	function Entropy.get_chipmult_score(...)
		local ret = chipmultref(...)
		if to_big(ret) > to_big(1e10) then return 10^400 end
		return ret
	end	
end
NES = {
	get_chipmult_score = function(mult, chips)
		local ret = mult * chips
		if to_big(ret) > to_big(1e10) then return 10^400 end
		return ret
	end
}