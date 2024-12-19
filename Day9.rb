def program
	file = "Day9.txt"
	lines = File.readlines(file, chomp: true)

	disk = lines[0]
	visualized = expose_free_space(disk)
	defraged = defragment(visualized)
	
	output_checksum(defraged)

end

def output_checksum(defraged)
	checksum = 0

	defraged.each_with_index do |file, i|
		checksum += file.to_i * i
	end

	puts "CHECKSUM: #{checksum}"
end

def defragment(visualized)
	just_files = visualized.clone
	just_files.delete(".")

	output = []

	(0..(visualized.length - 1)).each do |i|


		if visualized.find_index(just_files.last) <= i
			puts "DEFRAG COMPLETE"
			break
		end

		if visualized[i] == "."
			file = just_files.pop
			output << file
		else
			output << visualized[i]
		end
	end

	return output
end

def expose_free_space(disk)
	space = []

	is_file = true
	file_id = 0
	disk.chars.each do |c|
		if is_file
			(1..(c.to_i)).each.map{ space << file_id.to_s }
			file_id += 1 # increment
		else
			(1..(c.to_i)).each.map{ space << "." }
		end

		is_file = !is_file
	end

	return space
end

program()