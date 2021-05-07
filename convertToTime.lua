local translationTable = {
	ms = {'ms', 'milissegundos', 'milissegundo'},
	s = {'s', 'segundos', 'segundo'},
	m = {'m', 'minutos', 'minuto'},
	h = {'h', 'horas', 'hora'},
	d = {'d', 'dia', 'dias'},
	sem = {'sem', 'semana', 'semanas'},
	mes = {'mes', 'mês', 'meses'},
	ano = {'ano', 'anos'}
}
local singular2pluValues = {
	{'segundo', 'segundos'},
	{'minuto', 'minutos'},
	{'milissegundo', 'milissegundos'},
	{'hora', 'horas'},
	{'dia', 'dias'},
	{'semana', 'semanas'},
	{{'mês', 'mes'}, 'meses'},
	{'ano', 'anos'}
}

local formulasConvertion = {
	['ms>s'] = function (num)
		return num/1000
	end,
	['ms>m'] = function (num)
		return num/60000
	end,
	['ms>h'] = function (num)
		return num/3600000
	end,
	['ms>d'] = function (num)
		return num/86400000
	end,
	['ms>sem'] = function (num)
		return num/604800000
	end,
	['ms>mes'] = function (num)
		return num/2628000000
	end,
	['ms>ano'] = function (num)
		return num/31536000000
	end,
	
	['s>ms'] = function (num)
		return num*1000
	end,
	['s>m'] = function (num)
		return num/60
	end,
	['s>h'] = function (num)
		return num/3600
	end,
	['s>d'] = function (num)
		return num/86400
	end,
	['s>sem'] = function (num)
		return num/604800
	end,
	['s>mes'] = function (num)
		return num/2628000
	end,
	['s>ano'] = function (num)
		return num/31536000
	end,
	
	['m>ms'] = function (num)
		return num*60000
	end,
	['m>s'] = function (num)
		return num*60
	end,
	['m>h'] = function (num)
		return num/60
	end,
	['m>d'] = function (num)
		return num/1440
	end,
	['m>sem'] = function (num)
		return num/10080
	end,
	['m>mes'] = function (num)
		return num/43800
	end,
	['m>ano'] = function (num)
		return num/525600
	end,
	
	['h>ms'] = function (num)
		return num*3600000
	end,
	['h>s'] = function (num)
		return num*3600
	end,
	['h>m'] = function (num)
		return num*60
	end,
	['h>d'] = function (num)
		return num/24
	end,
	['h>sem'] = function (num)
		return num/168
	end,
	['h>mes'] = function (num)
		return num/730
	end,
	['h>ano'] = function (num)
		return num/8760
	end,
	
	['d>ms'] = function (num)
		return num*86400000
	end,
	['d>s'] = function (num)
		return num*86400
	end,
	['d>m'] = function (num)
		return num*1440
	end,
	['d>h'] = function (num)
		return num*24
	end,
	['d>sem'] = function (num)
		return num/7
	end,
	['d>mes'] = function (num)
		return num/30.416666666667
	end,
	['d>ano'] = function (num)
		return num/365
	end,
	
	['sem>ms'] = function (num)
		return num*604800000
	end,
	['sem>s'] = function (num)
		return num*604800
	end,
	['sem>m'] = function (num)
		return num*10080
	end,
	['sem>h'] = function (num)
		return num*168
	end,
	['sem>d'] = function (num)
		return num*7
	end,
	['sem>mes'] = function (num)
		return num/4.345
	end,
	['sem>ano'] = function (num)
		return num/52.143
	end,
	
	
	['mes>ms'] = function (num)
		return num*2628000000
	end,
	['mes>s'] = function (num)
		return num*2628000
	end,
	['mes>m'] = function (num)
		return num*43800
	end,
	['mes>h'] = function (num)
		return num*730
	end,
	['mes>d'] = function (num)
		return num*30.417
	end,
	['mes>sem'] = function (num)
		return num*4.345
	end,
	['mes>ano'] = function (num)
		return num/12
	end,
	
	['ano>ms'] = function (num)
		return num*31536000000
	end,
	['ano>s'] = function (num)
		return num*31536000
	end,
	['ano>m'] = function (num)
		return num*525600
	end,
	['ano>h'] = function (num)
		return num*8760
	end,
	['ano>d'] = function (num)
		return num*365
	end,
	['ano>sem'] = function (num)
		return num*52.143
	end,
	['ano>mes'] = function (num)
		return num*12
	end
}

function translateString(str)
	if (type(str) ~= 'string') then
		error('[translateString] Bad argument #1, expected string got \''..type(str)..'\'', 2)
	end
	str = str:lower()
	local translated = false
	for _, v in pairs(translationTable) do
		for i, v2 in ipairs(v) do
			if (v2 == str) then
				translated = v[1]
			end
		end
	end
	return translated
end

function pluralizar(num, singular)
	num = tonumber(num)
	if (not num) then
		error('[pluralizar] Bad argument #1, expected number got \''..type(num)..'\'', 2)
	end
	local plural = (num > 1 or num > -1)
	if (type(singular) ~= 'string') then
		error('[pluralizar] Bad argument #1, expected string got \''..type(singular)..'\'', 2)
	end
	local rightTerm = translateString(singular)
	if not rightTerm then
		error('[pluralizar] Invalid \'singular\' value specified', 2)
	end
	
	local pluralizedValue = false
	for _, v in ipairs(singular2pluValues) do
		for _, v2 in ipairs(v) do
			if (type(v2) == 'table') then
				for _, v3 in ipairs(v2) do
					if (v3 == rightTerm) then
						if (plural) then
							pluralizedValue = v[2]
						else
							pluralizedValue = v2[1]
						end
					end
				end
			else
				if (v2 == rightTerm) then
					if (plural) then
						pluralizedValue = v[2]
					else
						pluralizedValue = v[1]
					end
				end
			end
		end
	end
	return pluralizedValue
end

function convertToTime(num, convertion)
	num = tonumber(num)
	if not num then
		error('[convertToTime] Bad argument #1, expected a number got \''..type(num)..'\'', 2)
	end
	if (type(convertion) ~= 'string') then
		error('[convertToTime] Bad argument #2, expected string got \''..type(convertion)..'\'', 2)
	end
	local from, to = utf8.match(convertion, '(.+)>(.+)')
	if not (translateString(from) or translateString(to)) then
		error('[convertToTime] Bad argument #2, specified values are invalid', 2)
	end
	if not (from or to) then
		error('[convertToTime] Bad argument #2, coudn\'t get valid values', 2)
	end
	from2, to2  = translateString(from), translateString(to)
	local converter = formulasConvertion[from2..'>'..to2]
	if not converter then
		error('[convertToTime] Coudn\'t convert', 2)
	end
	return converter(num), math.round(converter(num))..' '..(pluralizar(num, to) or to)
end

function math.round(number)
    local _, decimals = math.modf(number)
    if decimals < 0.5 then return math.floor(number) end
    return math.ceil(number)
end