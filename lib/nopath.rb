# The NoPath class represents a an invalid Path
# This is a placeholder in 
# here: a station on a train route
# 
class NoPath
  # Getter method for weight of invalid path
  #
  # @return [Number] 0
  def weight
    0
  end
  # Getter method for number of edges of invalid path
  #
  # @return [Number] 0
  def edges
    0
  end
  # to_string method for invalid path
  #
  # @return [String] 'NO SUCH ROUTE'
  def to_s
    'NO SUCH ROUTE'
  end
end

NO_PATH = NoPath.new
# EndOfPath class inherits from NoPath
# 
# 
class EndOfPath < NoPath
  # to_string method for EndOfPath
  #
  # @return [String] ''
  def to_s
    ''
  end
end