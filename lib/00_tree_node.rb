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
      if new_parent == nil
         @parent = nil
      elsif @parent == new_parent
        nil
      elsif @parent == nil
        @parent = new_parent
        new_parent.add_child(self)
      else
        @parent.remove_child(self)
        @parent = new_parent
        new_parent.add_child(self)
      end
    end

    def add_child(new_child)
      @children.push(new_child) unless @children.include?(new_child)
      new_child.parent = self
    end

    def remove_child(old_child)
      raise "#{old_child} is not a child" unless @children.include?(old_child)
      @children.delete(old_child)
      old_child.parent = nil
    end

    def dfs(target)
      return self if self.value == target
      @children.each do |child|
        answer = child.dfs(target)
        return answer unless answer == nil
      end
      nil
    end

    def bfs(target)
      queue = [self]
      until queue.empty?
        answer = queue.shift
        return answer if answer.value == target
        queue += answer.children
      end
      nil
    end

end
