--[[
	Honestly don't really know what this is doing
]]

local bool_numerics = {
	[true] = 1,
	[false] = 0,
}

local function levenshtein(left: string, right: string): number
	local left_length = #left
	local right_length = #right

	local matrix = {}
	for left_index = 1, left_length + 1 do
		matrix[left_index] = table.create(right_length + 1, 0)
		matrix[left_index][1] = left_index - 1
	end

	local first_row = matrix[1]
	for right_index = 1, right_length + 1 do
		first_row[right_index] = right_index - 1
	end

	for left_index = 2, left_length + 1 do
		for right_index = 2, right_length + 1 do
			local last_left_index = left_index - 1
			local last_right_index = right_index - 1

			local last_left_row = matrix[last_left_index]
			local this_left_row = matrix[left_index]

			this_left_row[right_index] = math.min(
				-- deletion case
				last_left_row[right_index] + 1,
				-- insertion case
				this_left_row[last_right_index] + 1,
				-- substitution case
				last_left_row[last_right_index]
					+ bool_numerics[string.byte(left, last_left_index) ~= string.byte(right, last_right_index)]
			)
		end
	end

	return matrix[left_length + 1][right_length + 1]
end

return levenshtein
