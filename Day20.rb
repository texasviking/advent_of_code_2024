def program

	file = 'Day20.txt'
	lines = File.readlines(file, chomp: true)

	start_xy = find_start(lines)

	puts "START: #{start_xy}"

	end_xy = find_end(lines)

	puts "END: #{end_xy}"

	# find path
	path = find_path(lines, start_xy, end_xy)

	puts "PATH: #{path}"

	# check for cheats
	cheats = find_cheats(lines, path)

	puts "CHEATS: #{cheats.keys}"

	count_cheats_at_least_100(cheats)

	program2(path)
end 

def program2(path)

	super_cheats = 0

	path.each_with_index do |p, i|
		((i+1)..(path.length-1)).each do |i2|
			distance = distance_between_points(p, path[i2])
			if distance <= 20 && (i2 - i - distance) >= 100
				super_cheats += 1
			end
		end
	end

	puts "SUPER CHEATS: #{super_cheats}"

end

def distance_between_points(p1, p2)
	xdist = (p2[0] - p1[0]).abs
	ydist = (p2[1] - p1[1]).abs

	return xdist + ydist
end

def count_cheats_at_least_100(cheats)
	count = 0

	cheats.keys.each do |key|
		if key.to_i >= 102
			count += cheats[key].length
		end
	end

	puts "OVER 100ps saved CHEATS: #{count}"
end

def find_cheats(lines, path)

	cheats = {}

	path.each_with_index do |position, i|

		up_cheat = check_cheat(lines, [position[0], position[1] - 2])
		if !up_cheat.nil?
			cheat_index = path.index(up_cheat)
			if cheat_index > i + 2
				seconds_saved = (cheat_index - i).to_s
				if cheats[seconds_saved].nil?
					cheats[seconds_saved] = []
				end
				cheats[seconds_saved] << up_cheat
			end
		end

		right_cheat = check_cheat(lines, [position[0] + 2, position[1]])
		if !right_cheat.nil?
			cheat_index = path.index(right_cheat)
			if cheat_index > i + 2
				seconds_saved = (cheat_index - i).to_s
				if cheats[seconds_saved].nil?
					cheats[seconds_saved] = []
				end
				cheats[seconds_saved] << right_cheat
			end
		end

		down_cheat = check_cheat(lines, [position[0], position[1] + 2])
		if !down_cheat.nil?
			cheat_index = path.index(down_cheat)
			if cheat_index > i + 2
				seconds_saved = (cheat_index - i).to_s
				if cheats[seconds_saved].nil?
					cheats[seconds_saved] = []
				end
				cheats[seconds_saved] << down_cheat
			end
		end

		left_cheat = check_cheat(lines, [position[0] - 2, position[1]])
		if !left_cheat.nil?
			cheat_index = path.index(left_cheat)
			if cheat_index > i + 2
				seconds_saved = (cheat_index - i).to_s
				if cheats[seconds_saved].nil?
					cheats[seconds_saved] = []
				end
				cheats[seconds_saved] << left_cheat
			end
		end

	end

	return cheats

end

def check_cheat(lines, test_position)
	x = test_position[0]
	y = test_position[1]

	# check boundaries
	if x < 0 || x > (lines[0].length - 1) ||
	   y < 0 || y > (lines.length - 1)
	   return nil
	end

	# check for wall
	if [".", "S", "E"].include?(lines[y][x])
		return test_position
	end

	return nil
end

def find_path(lines, start_xy, end_xy)
	path = [start_xy]

	end_achieved = false
	last_position = start_xy
	current_position = start_xy

	while !end_achieved
		
		next_move = find_next_move(lines, current_position, last_position)
		path << next_move

		last_position = current_position
		current_position = next_move

		if next_move == end_xy
			end_achieved = true
		end
	end

	return path
end

def find_next_move(lines, position, last_position)

	x = position[0]
	y = position[1]

	# check up
	if ['.','E'].include?(lines[y-1][x]) && last_position != [x, y-1]
		return [x, y-1]
	end

	# check right
	if ['.','E'].include?(lines[y][x+1]) && last_position != [x+1, y]
		return [x+1, y]
	end

	# check down
	if ['.','E'].include?(lines[y+1][x]) && last_position != [x, y+1]
		return [x, y+1]
	end

	# check left
	if ['.','E'].include?(lines[y][x-1]) && last_position != [x-1, y]
		return [x-1, y]
	end

	throw "NO MOVES FOUND"

end

def find_start(lines)
	lines.each_with_index do |line, y|
		line.chars.each_with_index do |char, x|
			if char == 'S'
				return [x, y]
			end
		end
	end

	throw "NO START FOUND"
end

def find_end(lines)
	lines.each_with_index do |line, y|
		line.chars.each_with_index do |char, x|
			if char == 'E'
				return [x, y]
			end
		end
	end

	throw "NO END FOUND"
end

program()
