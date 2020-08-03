module A
  B = 42

  def f
    21
  end
end

A.module_eval do
  def self.f
    p B
  end
end

B = 15

A.f

# 例外が発生する

# 21が表示される

# 42が表示される

# 15が表示される

module A
  B = 42

  def f
    21
  end
end

A.module_eval(<<-CODE)
  def self.f
    p B
  end
CODE

B = 15

A.f


# 例外が発生する

# 21が表示される

# 42が表示される

# 15が表示される
