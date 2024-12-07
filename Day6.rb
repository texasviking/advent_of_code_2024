# --- Day 5: Print Queue ---

$map_file = 'Day6.txt'
$map_rows = File.readlines($map_file, chomp: true)

def program
	# find current guard location and update with X
	guard = find_guards_position
	puts "#{guard}"

	guard_on_map = true

	while guard_on_map
		# replace current position with X
		mark_guards_position(guard)
		
		# find guard's next move
		next_move = find_guards_next_move(guard)
		
		if next_move.nil?
			guard_on_map = false
		else
			guard = move_guard(guard, next_move)
		end
	end

	# count X's
	x_count = 0
	$map_rows.each do |map_row|
		x_count += map_row.count('X')
	end

	puts "Total Positions: #{x_count}"

end

def find_guards_position
	$map_rows.each_with_index do |map_row, i|
		direction = map_row.match(/[\^\>\<\v]/).to_s
		if !direction.empty?
			position = [i, map_row.index(direction.to_s)]
			return {direction: direction, position: position}
		end
	end
end

def mark_guards_position(guard)
	r = guard[:position][0]
	c = guard[:position][1]
	$map_rows[r][c] = 'X'
end

def find_guards_next_move(guard)
	case guard[:direction]
	when "^"
		if guard[:position][0] == 0
			# top of map pointed up
			return nil
		end

		next_position = [guard[:position][0] - 1, guard[:position][1]]
		if obstacle(next_position)
			guard[:direction] = ">"
			return find_guards_next_move(guard)
		end

		return next_position
	when "v"
		if guard[:position][0] == ($map_rows.length - 1)
			# bottom of map pointed down
			return nil
		end

		next_position = [guard[:position][0] + 1, guard[:position][1]]
		if obstacle(next_position)
			guard[:direction] = "<"
			return find_guards_next_move(guard)
		end

		return next_position
	when "<"
		if guard[:position][1] == 0
			# left edge of map pointed left
			return nil
		end

		next_position = [guard[:position][0], guard[:position][1] - 1]
		if obstacle(next_position)
			guard[:direction] = "^"
			return find_guards_next_move(guard)
		end

		return next_position
	when ">"
		if guard[:position][1] == ($map_rows[0].length - 1)
			# right edge of map pointed right
			return nil
		end

		next_position = [guard[:position][0], guard[:position][1] + 1]
		if obstacle(next_position)
			guard[:direction] = "v"
			return find_guards_next_move(guard)
		end

		return next_position
	end
end

def move_guard(guard, next_move)
	updated_guard = guard
	updated_guard[:position] = next_move
	return updated_guard
end

def obstacle(position)
	return $map_rows[position[0]][position[1]] == "#"
end

program();
