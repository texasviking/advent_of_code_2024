# Day2.rb

def program
	puts Time.now.to_i

	file1 = 'Day2_List1.txt'

	# load file1 into list
	list1 = File.readlines(file1).map(&:chomp)
	s2blist = []

	# let's get things smallest to largest regardless to simplify the math.
	while list1.length > 0
		line = list1.pop.split(' ')
		line_orig = line.clone


		if test_line_sameness(line)
			s2blist << "Unsafe | SAME | #{line_orig.to_a}"
			next
		end

		# lets make them consistent smallest to largest
		if line.first.to_i > line.last.to_i
			line = line.reverse
		end

		# check if increasing by 1, 2, or 3
		# pop will grab last of list first, so check if 

		# test for dampener by removing each element and testing the line again
		dampener_result = false

		if !test_line(line.clone)
			
			for i in 1..line.length
				testline = line.clone
				testline.delete_at(i-1)


				if test_line(testline)
					dampener_result = true
				end
			end
		else
			s2blist << "YesSafe"	
			next
		end

		if !dampener_result
			s2blist << "Unsafe | dampener | #{line_orig.to_a}"
			line = []
		else
			s2blist << "YesSafe"	
		end
	end

	puts "S2blist Safes: #{s2blist.select{|l| l == "YesSafe"}.length}"

	puts Time.now.to_i
end

def test_line_sameness(line)
	return line.first.to_i == line.last.to_i
end

def test_line(line)
	while line.length > 1
		val1 = line.pop.to_i
		val2 = line.last.to_i
		diff = val1 - val2
		if ![1, 2, 3].include?(diff)
			return false
		end
	end

	return true
end


program();