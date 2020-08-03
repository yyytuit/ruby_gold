mod = Module.new

mod.module_eval do
  EVAL_CONST = 100
end

puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST)}"
puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST)}"


# EVAL_CONST is defined? false
# EVAL_CONST is defined? true

# EVAL_CONST is defined? true
# EVAL_CONST is defined? true

# EVAL_CONST is defined? true
# EVAL_CONST is defined? false

# EVAL_CONST is defined? false
# EVAL_CONST is defined? false

# 定数のスコープはレキシカルに決定されます。
# ブロックはネストの状態を変更しないので、module_evalのブロックで定義した定数はこの問題ではトップレベルで定義したことになります。
# 定数EVAL_CONSTはトップレベルで定義していることになりますので、Objectクラスに定数あることが確認することが出来ます。

# また、Moduleクラスのインスタンスには直接、定数は定義されていませんが継承関係を探索して参照することが出来ます。
# const_defined?メソッドは第2引数に継承関係を探索するか指定出来るため、この問題では探索を行うかによって結果が変わります。

mod = Module.new

mod.module_eval do
  EVAL_CONST = 100
end

puts Object.const_defined? :EVAL_CONST # trueと表示される
puts mod.const_defined? :EVAL_CONST # trueと表示される

# # 第2引数にfalseを指定すると継承関係まで探索しない
# puts mod.const_defined? :EVAL_CONST, false # falseと表示される
# この問題では指定してない（デフォルト値true）ため探索を行い、定数をどちらも見つけることが出来ます。
# 結果は次のとおりです。

# EVAL_CONST is defined? true
# EVAL_CONST is defined? true


# 次のプログラムを実行するとどうなりますか
mod = Module.new

mod.module_eval do
  EVAL_CONST = 100
end

puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST, false)}"
puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST, false)}"


# 選択肢
EVAL_CONST is defined? false
EVAL_CONST is defined? false
# 選択肢
EVAL_CONST is defined? true
EVAL_CONST is defined? false
# 選択肢
EVAL_CONST is defined? false
EVAL_CONST is defined? true
# 選択肢
EVAL_CONST is defined? true
EVAL_CONST is defined? true

# 定数のスコープはレキシカルに決定されます。
# ブロックはネストの状態を変更しないので、module_evalのブロックで定義した定数はこの問題ではトップレベルて定義したことになります。
# また、文字列を引数とした場合はネストの状態を変更します。ネストの状態が変更されるので、この問題ではモジュールの中でプログラムを書いたことと同じことになります。

mod = Module.new

# ネストが変化しない
mod.module_eval do
  p Module.nesting # []
end

# ネストが変化する
mod.module_eval(<<-EVAL)
  p Module.nesting # [#<Module:0x007f83480723a8>]
EVAL
# ブロックと、文字列では次のような結果になります。
# この問題ではブロックを利用しているので、BLOCKと出力にあるものが答えになります。


mod = Module.new

mod.module_eval do
  CONST_IN_BLOCK = 100
end

mod.module_eval(<<-EVAL)
  CONST_IN_HERE_DOC = 100
EVAL

puts "BLOCK: CONST is defined? #{mod.const_defined?(:CONST_IN_BLOCK, false)}"
puts "BLOCK: CONST is defined? #{Object.const_defined?(:CONST_IN_BLOCK, false)}"

puts "HERE_DOC: CONST is defined? #{mod.const_defined?(:CONST_IN_HERE_DOC, false)}"
puts "HERE_DOC: CONST is defined? #{Object.const_defined?(:CONST_IN_HERE_DOC, false)}"

# 出力結果
# BLOCK: CONST is defined? false
# BLOCK: CONST is defined? true
# HERE_DOC: CONST is defined? true
# HERE_DOC: CONST is defined? false
