# The Destination class represents an end node in a graph
# 
class Destination
  attr_reader :node, :weight
  # get_paths_by_number_of_nodes
  #
  # @param [Vertex] node end_node 
  # @param [Fixnum] weight a weight
  # @return [Object] a destination object
  def initialize(node, weight)
    @node = node
    @weight = weight
  end
end