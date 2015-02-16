require 'rspec'
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file } #include all source files


describe 'Path' do

  context "a simple path" do

    it 'should return "" if empty' do
      path = Path.new
      expect(path.to_s).to eq ('0')
    end

    it 'can be created' do
      path = Path.new 'b', 'd'
      path.is_a? Path
    end

    it "should have start and end" do
      path = Path.new 'b', 'd'
      expect(path.start_node).to eq('b')
      expect(path.end_node).to eq('d')
    end

    it "should have weight" do
      path = Path.new 'b', 'd', 8
      expect(path.weight).to eq(8)
    end

    it "should print path as string" do
      path = Path.new 'b', 'd', 8
      expect(path.to_s).to eq('bd8')
    end


  end

end


describe "Destination" do
  new_destination = Destination.new("B", 20)
  it "should have a name" do
    expect(new_destination.node).to eq("B")
  end
  it "should have a weight" do
    expect(new_destination.weight).to eq(20)
  end

end


describe "Vertex" do
  new_vertex = Vertex.new("A")

  context "simple checks" do
    it "should have implemented to_s method" do
      expect(new_vertex.to_s).to eq("A")
    end
    it "should return no path" do
      expect(new_vertex.path("")).is_a? EndOfPath
      expect(new_vertex.path("").to_s).to eq ('')
    end
    it "should return no path if there is no path" do
      expect(new_vertex.path("path2")).is_a? NoPath
    end
    it "should have an added end node" do
      added_vertex = Vertex.new("B")
      expect(new_vertex.add_end_node(new_vertex.add_end_node(Destination.new(added_vertex, 20))).node.name).to eq('B')
    end
    it "should return all path" do
      other_vertex = Vertex.new("B")
      #expect(new_vertex.all_paths_to(other_vertex).length).to eq(1)
    end
  end

  context "adding a destination" do
    new_vertex2 = Vertex.new("B")
    new_destination = Destination.new(new_vertex2, 20)
    it 'is a destination node' do
      new_vertex.add_end_node(new_destination).is_a? Destination
    end
    it 'has a weight' do
      expect(new_vertex.add_end_node(new_destination).weight).to eq (20)
    end
    it 'has a node' do
      expect(new_vertex.add_end_node(new_destination).node).to eq (new_vertex2)
    end

    it "should show all available nodes" do
    end
  end
end


describe "connecting paths" do
  context 'single paths' do
    path1 = Path.new 'b', 'd', 8
    path2 = Path.new 'd', 'e', 4
    path1.connect path2
    it "should return total weight of path" do
      expect(path1.weight).to eq (12)
    end

    it "should return number of connected paths" do
      expect(path1.noOfConnections).to eq (1)
    end


  end
end

describe 'Route' do

  context 'provides rich API' do

    it 'should return empty path for undefined route' do
      route = Paths.new ''
      expect(route.nodes).to eq({})
    end
    it 'should give three nodes' do
      route = Paths.new 'AB3 BD2'
      expect(route.nodes.length).to eq(3)
    end
    it 'should fail if path is in wrong format' do
      expect(Paths.new('afaafsffe').nodes).to eq({})
    end
    it 'should return NoPath for empty start/end' do
      route = Paths.new 'AB3 BD2'
      test_route = route.get_paths_by_number_of_nodes(nil, nil)
      expect(test_route).is_a? NoPath
    end
    it 'should find 1 path' do
      route = Paths.new 'AB3 BD2'
      expect(route.get_paths_by_number_of_nodes('A', 'B').length).to eq(1)
    end

    it 'should the shortest path AB with weight 3' do
      route = Paths.new 'AB3 BD2 AD6 DB8'
      expect(route.get_shortest_path('A', 'B').weight).to eq (3)
    end

    it 'should return two path with weight <= 8' do
      route = Paths.new 'AB3 BD2 AD6 DB8 AC3 CB4'
      expect(route.get_paths_with_weight_lower_than('A', 'B',8).length).to eq (2)
    end
    it 'works with lower case as well' do
      route = Paths.new 'AB3 BD2 AD6 DB8 AC3 CB4'
      expect(route.get_paths_with_weight_lower_than('a', 'b',8).length).to eq (2)
    end
    it 'find path by exact number of nodes' do
      paths = Paths.new 'AB5 BC4 CE3 ED7 DA2'
      expect(paths.get_paths_by_exact_nodes('A', 'B', 'C', 'E', 'D', 'A').weight).to eq(21)
    end
  end
  context 'When things go wrong' do
    route= Paths.new 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'
    it 'A-E-D is an invalid path' do
      expect(route.get_paths_by_exact_nodes('A', 'E', 'D').to_s).to eq('NO SUCH ROUTE')
    end
    it 'invalid start' do
      expect(route.get_paths_by_maximum_nodes(nil, 'D')[0].to_s).to eq('NO SUCH ROUTE')
    end
    it 'invalid end' do
      expect(route.get_paths_by_maximum_nodes('A', nil)[0].to_s).to eq('NO SUCH ROUTE')
    end
    it 'start node not in graph' do
      expect(route.get_paths_by_maximum_nodes('g', 'D')[0].to_s).to eq('NO SUCH ROUTE')
    end
    it 'destination node not in graph' do
      expect(route.get_paths_by_maximum_nodes('A', 'g')[0].to_s).to eq('NO SUCH ROUTE')
    end
    it 'Empty parameters should return "NO SUCH ROUTE"' do
      expect(route.get_paths_by_exact_nodes().to_s).to eq('NO SUCH ROUTE')
    end
    it 'empty graph should return "NO SUCH ROUTE"' do
      empty_routes = Paths.new ''
      expect(empty_routes.get_paths_by_exact_nodes('a', 'b').to_s).to eq('NO SUCH ROUTE')
    end
  end

end

