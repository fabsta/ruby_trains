# The Vertex class represents a node in a graph
# here: a station on a train route
# 
class Vertex
  # @attr_reader [:name] name description of a readonly attribute
  attr_reader :name
  # Initialises a vertex object
  #
  # @param [Symbol] name name of the vertex 
  # @return [String] the vertex object
  def initialize(name)
    @name = name
    @edges = {}
  end

  # Converts the object into textual markup given a specific format.
  #
  # @param [Symbol] vertex_names 
  # @return [String] the object converted into the expected format.
  def path(vertex_names) 
    if vertex_names == nil || vertex_names.empty?
      return EndOfPath.new 
    end
    destination_node = @edges[vertex_names[0]]
    if destination_node == nil
      return NO_PATH 
    end
    connecting_vertex_names = vertex_names.slice 1,vertex_names.length
    build_path_to(destination_node).connect_to(connecting_vertex_names)
  end
  # Lists all paths to a given end node
  #
  # @param [Object] end_node end node
  # @param [Number] max_edges max number of allowed edges a path might have
  # @param [Number] edges number of edges of current path
  # @return [array] array of currently accepted paths
  def all_paths_to(end_node, max_edges=100 , edges=0)
    paths = []
    if edges == max_edges
      return []
    end
    direct_paths = build_direct_path_to(end_node)
    paths.concat(direct_paths)
    connection_paths = build_connection_paths_to(end_node, max_edges, edges)
    paths.concat(connection_paths)
    
  end
  # build_connection_paths_to
  #
  # @param [Object] end_node end node
  # @param [Number] max_edges max number of allowed edges a path might have
  # @param [Number] edges number of edges of current path
  # @return [array] array of currently accepted paths
  def build_connection_paths_to(end_node, max_edges, edges)
    connecting_paths = []
    # go over all 
    @edges.each_value do |destination|
      destination.node.all_paths_to(end_node, max_edges, edges + 1).each do |connection|
        new_path = build_path_to(destination).connect(connection)
        connecting_paths.push(new_path)
      end
    end
    connecting_paths
  end
  # build_direct_path_to
  #
  # @param [Fixnum] final_destination end node
  # @return [Array] array that contains path to the end node
  def build_direct_path_to(final_destination)
    direct_path = path(final_destination.name)
    if direct_path == NO_PATH
      return [] 
    end
    [direct_path]
  end
  # build_path_to: add a new path to the specified destination
  #
  # @param [Fixnum] destination end node
  # @return [Path] new path object
  def build_path_to(destination)
    Path.new(self, destination.node, destination.weight)
  end
  # add_end_node
  #
  # @param [Fixnum] destination end node
  # @return [Array] edges 
  def add_end_node(destination)
    @edges[destination.node.name] = destination
  end
  # Checks if name is empty or not
  #
  # @return [Boolean] True or false
  #def empty?
  #  @name.empty?
  #end
  # String representation of Vertex object
  #
  # @return [String] String of vertex name
  def to_s
    @name
  end

end