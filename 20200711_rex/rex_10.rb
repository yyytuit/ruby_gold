class C
  def self.m1
    'C.m1'
  end
end

module M
  refine C.singleton_class do
    def m1
      'C.m1 in M'
    end
  end
end

using M

puts C.m1

class C
  def self.m1
    p self
  end
end

module M
  refine C.singleton_class do
    def m1
      p self
    end
  end
end

using M

puts C.m1


class C
  def self.m1
    200
  end
end

module R
  refine C do
    def self.m1
      100
    end
  end
end

using R

puts C.m1
