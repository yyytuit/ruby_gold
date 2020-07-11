# module M
#   CONST = "Hello, world"
# end

# M.instance_eval(<<-CODE)
#   def say
#     CONST
#   end
# CODE

# p M::say

module M
  CONST = "Hello, world"
end

M.module_eval(<<-CODE)
  def self.say
    CONST
  end
CODE

p M::say


