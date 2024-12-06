# --- Day 4: Ceres Search ---
# "Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

# As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her word search (your puzzle input). She only has to find one word: XMAS.

# This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where irrelevant characters have been replaced with .:


# ..X...
# .SAMX.
# .A..A.
# XMAS.S
# .X....
# The actual word search will be full of letters instead. For example:

# MMMSXXMASM
# MSAMXMSMSA
# AMXSXMAAMM
# MSAMASMSMX
# XMASAMXAMM
# XXAMMXXAMA
# SMSMSASXSS
# SAXAMASAAA
# MAMMMXMMMM
# MXMXAXMASX
# In this word search, XMAS occurs a total of 18 times; here's the same word search again, but where letters not involved in any XMAS have been replaced with .:

# ....XXMAS.
# .SAMXMS...
# ...S..A...
# ..A.A.MS.X
# XMASAMX.MM
# X.....XA.A
# S.S.S.S.SS
# .A.A.A.A.A
# ..M.M.M.MM
# .X.X.XMASX
# Take a look at the little Elf's word search. How many times does XMAS appear?



$file = 'Day4.txt'
$lines = File.readlines($file, chomp: true)
$word = ['X','M','A','S']
$instances_found = 0

def program

	# find all coordinates of first letter in word
	x_points = []

	$lines.each_with_index do |line, linei|
		line.chars.each_with_index do |letter, letteri|
			
			# find "X" locations
			if letter == $word[0]
				x_points << [linei, letteri]
			end

		end
	end

	# for each "X" location, seek the next letter in the word array
	for x_point in x_points
		# break if $instances_found > 10
		seek_next_letter_points(x_point, 1)
	end

	puts "WE FOUND !! #{$instances_found} !!"

end

def seek_next_letter_points(x_point, next_letter_index)

	puts "LETTER: X - #{x_point}"

	seek_next_letter(x_point, next_letter_index, [0, 1])	# forwards #202
	seek_next_letter(x_point, next_letter_index, [0, -1])	# backwards #204
	
	seek_next_letter(x_point, next_letter_index, [1, 0])	# down #228
	seek_next_letter(x_point, next_letter_index, [-1, 0])	# up #227
	
	seek_next_letter(x_point, next_letter_index, [1, 1])	# diagrightdown #369
	seek_next_letter(x_point, next_letter_index, [1, -1])	# diagrightup #400
	
	seek_next_letter(x_point, next_letter_index, [-1, 1])	# diagleftdown #464
	seek_next_letter(x_point, next_letter_index, [-1, -1])	# diagleftup #478

end

def next_point(point, move)
	move_row = point[0] + move[0]
	move_col = point[1] + move[1]
	test_point = [move_row, move_col]

	if  move_row >= 0 && 
		move_col >= 0 && 
		!$lines[test_point[0]].nil? && 
		!$lines[test_point[0]][test_point[1]].nil?
		return test_point
	end

	return nil
end

def is_next_letter(y_point, next_letter)
	return $lines[y_point[0]][y_point[1]] == next_letter
end

def seek_next_letter(x_point, next_letter_index, move)
	
	next_letter = $word[next_letter_index]
	if next_letter.nil?
		puts "FOUND - #{next_letter_index}"
		$instances_found += 1
		return
	end

	y_point = next_point(x_point, move)
	if !y_point.nil?
		if is_next_letter(y_point, next_letter)
			puts "LETTER: #{next_letter} - #{y_point}"
			seek_next_letter(y_point, next_letter_index + 1, move)
		end
	end
end



# program();

$x_mas_matches = 0

def program2

	for r in 0..($lines.length - 1)
		for c in 0..($lines[0].length - 1)
			grid = $lines[r..(r+2)].map{|l| l.chars[c..(c+2)].join}
			next if grid.length < 3
			test_x_mas_matches(grid)
		end
	end

	puts "MATCHES: #{$x_mas_matches}"

end

def test_x_mas_matches(grid)

	patterns = [
		# ['.M.','MAS','.S.', 1],
		# ['.S.','MAS','.M.', 2],
		# ['.M.','SAM','.S.', 3],
		# ['.S.','SAM','.M.', 4],
		# ['M.M','.A.','S.S', 5],
		['S.S','.A.','M.M', 6] #,
		# ,['M.S','.A.','M.S', 7],
		# ,['S.M','.A.','S.M', 8]
	]

	patterns.each do |pattern|
		if pattern_match(grid, pattern)
			puts "MATCH - #{pattern[3]}"
			puts "#{grid[0]} - #{pattern[0]}"
			puts "#{grid[1]} - #{pattern[1]}"
			puts "#{grid[2]} - #{pattern[2]}"
			$x_mas_matches += 1
		end
	end

	return false

	return patterns.include?(grid)

end

def pattern_match(grid, pattern)
	if !grid[0].match(pattern[0]).nil? &&
	   !grid[1].match(pattern[1]).nil? &&
	   !grid[2].match(pattern[2]).nil?
	   return true
	end

	return false
end




program2()