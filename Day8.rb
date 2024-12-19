$lines = []
$nodes = {}
$antinodes = {}

def program

	file = 'Day8.txt'
	$lines = File.readlines(file, chomp: true)

	# find nodes
	$lines.each_with_index do |line, y|
		chars = line.chars
		chars.each_with_index do |c, x|
			if c != '.'
				add_to_nodes(c, x, y)
			end
		end
	end

	# find antinodes
	$nodes.keys.each do |key|
		$antinodes[key] = scan_locations($nodes[key])
	end

	count_distinct_antinodes($antinodes)

end

def count_distinct_antinodes(an)
	locations = []
	an.keys.each do |key|
		puts "NODE: #{key}"
		puts "LOCATIONS: #{$nodes[key]}"
		puts "ANTI LOCATIONS: #{an[key]}"
		locations += an[key]
	end

	puts "TOTAL_LOCATIONS: #{locations.length}"
	puts "TOTAL UNIQ LOCS: #{locations.uniq().length}"
end

def add_to_nodes(c, x, y)
	if $nodes[c].nil?
		$nodes[c] = []
	end

	$nodes[c] << [x, y]
end

def scan_locations(locations)
	possible_antinodes = []

	locations.each do |location|
		other_locations = locations.clone
		other_locations.delete(location)
		possible_antinodes += find_antinodes(location, other_locations)
	end

	return possible_antinodes.uniq()
end

def find_antinodes(location, other_locations)
	possibilities = []

	other_locations.each do |ol|
		antinodes = math_antinodes(location, ol)
		possibilities += antinodes
	end

	return remove_invalid_antinodes(possibilities)
end

def remove_invalid_antinodes(possibilities)
	xmax = $lines[0].length - 1
	ymax = $lines.length - 1

	valid = []

	possibilities.each do |p|
		if (0..xmax).include?(p[0].to_i) &&
		   (0..ymax).include?(p[1].to_i)
		   valid << p
		end
	end

	return valid
end

def math_antinodes(l1, l2)
	xd = l2[0] - l1[0]
	yd = l2[1] - l1[1]

	x1, x2, y1, y2 = nil

	if xd >= 0
		x1 = l1[0] - xd
		x2 = l2[0] + xd
	else
		x1 = l2[0] - xd.abs
		x2 = l1[0] + xd.abs
	end

	if yd >= 0
		y1 = l1[1] - yd
		y2 = l2[1] + yd
	else
		y1 = l2[1] - yd.abs
		y2 = l1[1] + yd.abs
	end

	output = [[x1,y1], [x2,y2]]
	return output
end

program()


