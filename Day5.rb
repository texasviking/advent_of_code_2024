# --- Day 5: Print Queue ---

$page_rules_file = 'Day5.txt'
$page_rules = File.readlines($page_rules_file, chomp: true)

def program

	
	print_orders_file = 'Day5_2.txt'
	print_orders = File.readlines(print_orders_file, chomp: true)

	valid_orders = []

	print_orders.each do |order|
		puts order
		order_a = order.split(',')
		if test_print_order(order_a.first, order_a.drop(1))
			valid_orders << order_a
		end
	end

	puts "#{valid_orders.count} ORDERS FOUND"

	mid_page_total = 0
	valid_orders.each do |order|
		middle_page = order[order.length / 2]
		puts middle_page
		mid_page_total += middle_page.to_i
	end

	puts "Middle Page Total: #{mid_page_total}"

end

def test_print_order(page, other_pages)
	# puts "TEST: #{page}, OP: #{other_pages}"
	if other_pages.length > 0
		if !test_print_order(other_pages.first, other_pages.drop(1))
			return false
		end

		other_pages.each do |op|test = "#{op}|#{page}"
			# puts test
			if $page_rules.include?(test)
				# puts "FAILURE"
				return false
			end
		end
	end

	# puts "SUCCESS"
	return true
end

program();
