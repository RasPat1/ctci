class SortedMerge
  def call(a,b)
    p1 = a.size - 1
    p2 = b.size - 1
    last_open = a.size - 1

    while a[p1] == nil && p1 >= 0
      p1 -= 1
    end

    while p2 >= 0
      a_num = a[p1]
      b_num = b[p2]

      if p1 >= 0 && a_num > b_num
        a[last_open] = a_num
        p1 -= 1
      else
        a[last_open] = b_num
        p2 -= 1
      end

      last_open -= 1
    end

    a
  end
end

a = [1,2,4,5,6,nil,nil,nil]
b = [3,5,9]

p SortedMerge.new.call(a,b)