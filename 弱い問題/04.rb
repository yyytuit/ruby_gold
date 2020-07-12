# 27問目 x 4

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

# 解説
# module_evalにブロックを渡した場合のネストは次の通りです。

A.module_eval do
  p Module.nesting # []と表示され、ネストされた状態になく、トップレベルにいることがわかる
end
# トップレベルで定数を定義した場合はObjectの定数になります。

B = "Hello, world"
p Object.const_get(:B) # "Hello, world"と表示される
# 問題にあるメソッドA.fはトップレベルにある定数を探索するため答えは15になります。
