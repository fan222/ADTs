require_relative 'tree'

class KnightPathFinder
  DELTAS = [[-2, 1], [-1, 2], [1,2], [2,1], [2, -1], [1,-2], [-1, -2], [-2, -1]]
  def self.valid_move(pos)
    possible_moves = []
    DELTAS.each do |increment|
      new_move = [pos.first + increment.first, pos.last+increment.last]
      possible_moves.push(new_move) if (0..7).include?(new_move.first) && (0..7).include?(new_move.last)
    end
    possible_moves
  end

  def initialize(pos)
    @position = pos
    @visited_positions = [pos]
  end

  def visited_positions
    @visited_positions
  end

  def new_move_positions(pos)
    possible_moves = KnightPathFinder.valid_move(pos)
    @visited_positions.each do |position|
      possible_moves.delete(position)
    end
    @visited_positions += possible_moves
    possible_moves
  end

  def build_move_tree
    very_root = PolyTreeNode.new(@position)
    queue = [very_root]
    tree = [very_root]
    until queue.empty?
      root=queue.shift
      children_positions = self.new_move_positions(root.value)
      children_positions.each do |children_position|
        child = PolyTreeNode.new(children_position)
        root.add_child(child)
        tree.push(child)
        queue.push(child)
      end
    end
    tree
  end

  def find_path(end_pos)
    end_obj=nil
    tree = self.build_move_tree
    tree.each do |obj|
      end_obj = obj if obj.value == end_pos
    end
    trace_path_back(end_obj)
  end

  def trace_path_back(end_obj)
    path = [end_obj]
    positions =[end_obj.value]
    until positions.first == @position
      path.unshift(path.first.parent)
      positions.unshift(path.first.value)
    end
    positions
  end
end
