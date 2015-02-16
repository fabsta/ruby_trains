# The Paths class represents a set of paths 
# 
class Paths
  attr_reader :nodes
  # Initializes a paths object
  #
  # @param [Fixnum] path_data First number to add
  # @return [Array] Array of accepted paths
  def initialize(path_data)
    @nodes = {}
    path_data.scan(/[a-zA-Z]{2}\d/) do |path|
      start,destination, weight  = path[0].upcase,path[1].upcase,path[2].to_i

      # Add start node to list of nodes
      if !@nodes.has_key?(start)
        @nodes[start] = Vertex.new(start)    
      end  
      start_node = @nodes[start]
      # Add destination node to list of nodes
      if !@nodes.has_key?(destination)
        @nodes[destination] = Vertex.new(destination)    
      end  
      destination_node = @nodes[destination]
      # Attach destination_node to start_node
      start_node.add_end_node(Destination.new(destination_node,weight))
    end
    #if @nodes.empty?
    #  'WRONG_GRAPH_FORMAT'
    #end
  end
    # get_paths_by_number_of_nodes
    #
    # @param [Fixnum] start First number to add
    # @param [Fixnum] destination Second number to add
    # @return [Array] Array of accepted paths
  def get_paths_by_number_of_nodes(start, destination, number_of_edges=1)
    if(start == nil || destination == nil)
      return [NO_PATH]
    else
      all_paths = get_paths_by_maximum_nodes(start, destination, number_of_edges)
      all_paths.keep_if do |path|
        path.edges == number_of_edges
      end
    end
  end
  # get_paths_by_number_of_nodes
  #
  # @param [Fixnum] args the start node
  # @return [Array] Array of accepted paths
  def get_paths_by_exact_nodes(*args)
    if args.length < 2
      return NO_PATH 
    end
    if !@nodes.has_key?(args[0])
      @nodes[args[0]] = Vertex.new(args[0])    
    end  
    start_node = @nodes[args[0]]
    start_node.path(args.slice(1,args.length))
  end
  # get_paths_by_maximum_nodes
  #
  # @param [Fixnum] start the start node
  # @param [Fixnum] destination the end node
  # @return [Array] Array of accepted paths
  def get_paths_by_maximum_nodes(start, destination, max_edges=15)
    if(start == nil || destination == nil)
        return [NO_PATH]
    else
        if !@nodes.has_key?(start)
            return [NO_PATH]
            #@nodes[start] = Vertex.new(start)
        end  
        start_node = @nodes[start]
        if !@nodes.has_key?(destination)
            return [NO_PATH]
            #@nodes[destination] = Vertex.new(destination)
        end  
        destination_node = @nodes[destination]
        start_node.all_paths_to( destination_node, max_edges)
    end
  end
  # get_shortest_path
  #
  # @param [Fixnum] start the start node
  # @param [Fixnum] destination the end node
  # @return [Array] Array of accepted paths
  def get_shortest_path(start, destination)
    all_paths = get_paths_by_maximum_nodes(start.upcase, destination.upcase)
    all_paths.min { |path_a, path_b| path_a.weight <=> path_b.weight }
  end
  # get_paths_with_weight_lower_than
  #
  # @param [Fixnum] start the start node
  # @param destination [Fixnum] end node 
  # @return [Array] Array of paths that are below max_weight
  def get_paths_with_weight_lower_than(start, destination, max_weight)
    all_paths = get_paths_by_maximum_nodes(start.upcase, destination.upcase)
    all_selected_paths = []
    all_paths.each do |path|
      if(path.weight < max_weight)
        all_selected_paths.push(path)
      end
    end
    all_selected_paths
  end
end