require_relative "PolyTreeNode"
require "byebug"
DELTAS = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]

class KnightPathFinder
  attr_reader :start_pos

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [@start_pos]
    @root_node = nil
    build_move_tree
  end

  def self.valid_moves(pos)
    moves = []
    DELTAS.each do |increment|
      new_position= [pos[0]+increment[0],pos[1]+increment[1]]
      if new_position.valid?
        moves << new_position
      end
    end
    moves
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_moves(pos)
    possible_moves.delete_if do |move|
      # debugger
      @visited_positions.include?(move)
    end
    @visited_positions += possible_moves
    possible_moves
  end


  def build_move_tree
    @root_node = PolyTreeNode.new(@start_pos)
    queue = [@root_node]
    until queue.empty?
      root = queue.shift
      children_moves = self.new_move_positions(root.value)
      children_moves.each do |move|
        child = PolyTreeNode.new(move)
        root.add_child(child)
        queue.push(child)
      end
    end
  end

  def find_path(end_pos)
    end_node = @root_node.bfs(end_pos)
    trace_path_back(end_node).reverse.map(&:value)
  end

  def trace_path_back(end_node)
    nodes = []
    current_node = end_node
    until current_node.nil?
      nodes << current_node
      current_node = current_node.parent
    end
    nodes
  end

end

class Array
  def valid?
    x,y = self
    (0..7).include?(x) && (0..7).include?(y)
  end
end

if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new([0,0])
  p kpf.find_path([7, 6])
end
