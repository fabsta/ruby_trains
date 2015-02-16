# This runnable performs some basic graph operations
# like calculating the total weight of a path or the shortest path
#
# It either accepts a file with defined graph or uses a default graph
#
#
# @author Fabian Schreiber
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

if ARGV.length == 1
  route = Paths.new(File.open(ARGV[0], "r").read.chomp)
else
  route = Paths.new 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'
end

# 1.
puts "Output #1: #{route.get_paths_by_exact_nodes('A','B','C').weight}"
# 2.
puts "Output #2: #{route.get_paths_by_exact_nodes('A','D').weight}"
# 3.
puts "Output #3: #{route.get_paths_by_exact_nodes('A','D','C').weight}"
# 4.
puts "Output #4: #{route.get_paths_by_exact_nodes('A','E','B','C','D').weight}"
# 5.
puts "Output #5: #{route.get_paths_by_exact_nodes('A','E','D')}"
# 6.
puts "Output #6: #{route.get_paths_by_maximum_nodes('C', 'C', 3).length}"
# 7.
puts "Output #7: #{route.get_paths_by_number_of_nodes('A', 'C', 4).length}"

## shortest path
# 8.
puts "Output #8: #{route.get_shortest_path('A', 'C').weight}"
# 9.
puts "Output #9: #{route.get_shortest_path('B', 'B').weight}"
## Paths with a total weight lower than 30
# 10.
puts "Output #10: #{route.get_paths_with_weight_lower_than('C', 'C', 30).length}"

