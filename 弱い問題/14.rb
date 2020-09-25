# 次のプログラムと同じ結果になる選択肢を選んでください。
# 答え 2,3,4

module M
  def self.a
    100
  end
end

p M.a

# 選択肢
module M
  include self
  def a
    100
  end
end

p M.a


# 選択肢
module M
  extend self
  def a
    100
  end
end

p M.a



# 選択肢
module M
  def a
    100
  end

  module_function :a
end

p M.a


# 選択肢
module M
  class << self
    def a
      100
    end
  end
end

p M.a
