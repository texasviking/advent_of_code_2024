# --- Day 5: Print Queue ---

$page_rules_file = 'Day5.txt'
$page_rules = File.readlines($page_rules_file, chomp: true)

def program

	
	print_orders_file = 'Day5_2.txt'
	print_orders = File.readlines(print_orders_file, chomp: true)

	valid_orders = []

	print_orders.each do |order|

		order_a = order.split(',')
		if test_print_order(order_a.first, order_a.drop(1))
			valid_orders << order_a
		end
	end


	mid_page_total = 0
	valid_orders.each do |order|
		middle_page = order[order.length / 2]

		mid_page_total += middle_page.to_i
	end


end

def test_print_order(page, other_pages)
	if other_pages.length > 0
		if !test_print_order(other_pages.first, other_pages.drop(1))
			return false
		end

		other_pages.each do |op|test = "#{op}|#{page}"
	
			if $page_rules.include?(test)
		
				return false
			end
		end
	end

	return true
end

# program();


def program2

	print_orders_file = 'Day5_2.txt'
	print_orders = File.readlines(print_orders_file, chomp: true)

	invalid_orders = []

	print_orders.each do |order|

		order_a = order.split(',')
		if !test_print_order(order_a.first, order_a.drop(1))
			invalid_orders << order_a
		end
	end


	valid_orders = []

	invalid_orders.each do |invalid_order|
		valid_order = fix_invalid_order(invalid_order)
		valid_orders << valid_order
	end

	mid_page_total = 0
	valid_orders.each do |order|
		middle_page = order[order.length / 2]

		mid_page_total += middle_page.to_i
	end

	puts "MIDPAGE TOTAL: #{mid_page_total}"
end

def fix_invalid_order(invalid_order)

	puts "INVALID: #{invalid_order}"
	valid_order = []
	is_invalid = true

	while is_invalid

		result = test_print_order2(invalid_order.first, invalid_order.drop(1))
		if result[:outcome]
			is_invalid = false
		else
			bad_actor = result[:test].split('|').first # 12|24 => 12
			failure_index = invalid_order.find_index(bad_actor)
			val = invalid_order.delete_at(failure_index)
			invalid_order.insert(failure_index - 1, val)
		end
	end

	puts "VALID  : #{invalid_order}"
	return invalid_order
end

def test_print_order2(page, other_pages)
	if other_pages.length > 0
		result = test_print_order2(other_pages.first, other_pages.drop(1))
		if result[:outcome] == false
			return result
		end

		other_pages.each do |op|test = "#{op}|#{page}"
	
			if $page_rules.include?(test)
		
				return {outcome: false, test: test}
			end
		end
	end

	return {outcome: true, test: ""}
end

program2();


