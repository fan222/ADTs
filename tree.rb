class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(new_parent)
    # if @parent
    #   @parent.remove_child(self)
    # end
    # @parent = parent
    # @parent.children.push(self)
    if new_parent == nil
      @parent = nil
    elsif @parent.nil?
      @parent = new_parent
      new_parent.children.push(self)
    else
      @parent.children.delete(self)
      @parent = new_parent
      new_parent.children.push(self)
    end
  end

  def remove_child(child)
    raise unless @children.include?(child)
    @children.delete(child)
    child.parent = nil
  end

  def add_child(child)
    if @children.include?(child) == false
      child.parent = self
    end
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      answer = child.dfs(target_value)
      return answer unless answer.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      root = queue.shift
      return root if root.value == target_value
      queue += root.children
    end
    nil
  end
  



end
