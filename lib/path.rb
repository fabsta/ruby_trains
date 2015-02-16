# The Path class represents a node in a graph
# here: a station on a train route
# 
class Path
  attr_reader :start_node
  attr_reader :end_node
  attr_reader :weight
  # Initialises a path
  #
  # @param [Character] start_node Start node
  # @param [Character] end_node End node
  # @param [Number] weight weight of edge connecting start and end node
  # @return [Array] Sum of the two arguments
  def initialize(start_node = nil, end_node = nil, weight = 0)
    @start_node = start_node
    @end_node = end_node
    @weight = weight
    @edges = EndOfPath.new
  end
  # Getter method for edges
  #
  # @return [Number] number of edges
  def edges
    1 + @edges.edges
  end
  # Getter method for weight
  #
  # @return [Number] weight of the path
  def weight
    @weight + @edges.weight
  end
  # to_string method for Path object
  #
  # @return [String] String representation of Path object
  def to_s
    "#{@start_node}#{@end_node}#{weight.to_s}"
  end
  # setter for edges of a path
  #
  # @param [Object] path a path
  # @return [Object] Path object
  def connect(path)
    @edges = path
    self
  end
  # setter for connections of path
  #
  # @param [Array] vertex_names vertices to connect the path to
  # @return [Object] Path object 
  def connect_to(vertex_names)
    connection = @end_node.path(vertex_names)
    if connection == NO_PATH
      return connection 
    end
    connect(connection)
  end

  def noOfConnections
    (@edges.nil? ? 0:1)
  end
end