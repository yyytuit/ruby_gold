module A
  B = 42

  def f
    21
  end
end

A.module_eval(<<-CODE)
  def self.f
    p Module.nesting
    p B
  end
CODE

# A.module_eval do
#   def self.f
#     p Module.nesting
#     p B
#   end
# end

B = 15

A.f

#[A]
# 42

#[]
#15


