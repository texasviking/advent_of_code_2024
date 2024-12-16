def program

	file = "Day7.txt"
	lines = File.readlines(file, chomp: true)

	sum_result = 0

	lines.each do |line|
		parts = line.split(":")
		total = parts[0]
		numbers = parts[1].split(" ")

		length = numbers.length
		bformat = "%0#{length - 1}b"

		success = false
		i = 0

		puts "TOTAL: #{total} | NUMBERS: #{numbers}"

		while !success
			operators = (bformat % i).gsub("0","+").gsub("1","*")

			math = numbers.zip(operators.chars).flatten.compact.join(" ")
			result = eval(math)
			puts "OUTCOME: #{total == result.to_s} TOTAL: #{total} | RESULT: #{result} | OPERATION: #{math}"

			if total == result.to_s
				puts "SUCCESS: #{operators}"
				sum_result += result
				success = true
			end

			if operators.chars.all?("*")
				puts "FAILED"
				break
			end

			i += 1
		end
	end

	puts "SUM RESULT: #{sum_result}"

end

program()