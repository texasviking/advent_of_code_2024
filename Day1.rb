# Day1.rb

# Location ID

# 2 groups

# smallest in left with smallest in right
# next smallest in left with second smallest in right
# etc
# Measure the difference between the IDs (so 1, and 4 would mean a distance of 3)

def program
	puts Time.now.to_i

	file1 = 'Day1_List1.txt'
	file2 = 'Day1_List2.txt'

	# load file1 into list
	list1 = File.readlines(file1).map(&:chomp).sort

	# load file2 into list
	list2 = File.readlines(file2).map(&:chomp).sort

	total_diff = 0

	while list1.length > 0
		val1 = list1.pop
		val2 = list2.pop
		diff = val2.to_i - val1.to_i
		puts "List1: #{val1} | List2: #{val2} | Diff: #{diff} | AbsoluteVal: #{diff.abs}"
		total_diff += diff.abs
	end
		
	puts "Total Diff: #{total_diff}"
	puts Time.now.to_i

	puts "Part 2:"
	puts Time.now.to_i

	list1 = File.readlines(file1).map(&:chomp).sort
	list2 = File.readlines(file2).map(&:chomp).sort

	total_similarity = 0

	while list1.length > 0
		val1 = list1.pop.to_i
		count2 = list2.select{|v| v.to_i == val1}.length

		total_similarity += val1 * count2
	end

	puts "Total Similarity: #{total_similarity}"
	puts Time.now.to_i
end


program();