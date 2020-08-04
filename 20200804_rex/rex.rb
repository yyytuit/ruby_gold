# 4問 x 1 4
# Rubyで使用可能なオプションではないものを選択しなさい(複数)。

# 選択肢
# -t

# 選択肢
# -l

# 選択肢
# -p

# 選択肢
# -f

# -l: 各行の最後に String#chop!を実行します。
# -p: -nと同じだが$_を出力
# -t: このオプションはありません。
# -f: このオプションはありません。

# 7問 x 1
# def hoge(&block, *args)
#   block.call(*args)
# end

# hoge(1,2,3,4) do |*args|
#   p args.length > 0 ? "hello" : args
# end

# 選択肢
# エラーが発生する

# 選択肢
# "hello"と表示される

# 選択肢
# 警告が表示される

# 選択肢
# [1,2,3,4]と表示される



# 8問 x 4

class C
  def m1
    400
  end
end

module M
  refine C do
    def m1
      100
    end
  end
end

class C
  using M
end

puts C.new.m1


# 選択肢
# 100と表示される

# 選択肢
# 200と表示される

# 選択肢
# エラーになる

# 選択肢
# 400と表示される

# Refinementは有効化したスコープのみに影響を与えることが出来ます。
# この問題ではクラスオープンした際にusingでRefinementを有効化していますが、
# スコープ外は無効になります。

# よって、puts C.new.m1とした結果は400になります。


# 16問 x 4

p [1,2,3,4].map(&self.method(:*))

# 選択肢
# [1, 4, 9, 16]

# 選択肢
# [1, 2, 3, 4]

# 選択肢
# nil

# 選択肢
# エラーになる

# 問題のselfはObjectクラスのインスタンスになります。
# Objectクラスには*メソッドが定義されていないためエラーになります。


# 20問 x 1

def foo(arg:)
  puts arg
end

foo 100


# 選択肢
# エラーになる

# 選択肢
# nilと表示される

# 選択肢
# 100と表示される

# 選択肢
# 0と表示される

# 問題のコードはArgumentError: missing keyword: argが発生します。

# argはキーワード引数と言います。キーワード引数は省略することができません。

# 問題のコードは次のように修正します。

def foo(arg:)
  puts arg
end

foo arg: 100

# 27問 x 2
class C
  @@val = 10
end

module B
  @@val = 30
end

module M
  include B
  @@val = 20

  class << C
    p @@val
  end
end

# 選択肢
# 10が表示される

# 選択肢
# 20が表示される

# 選択肢
# 30が表示される

# 選択肢
# 例外が発生する

# クラス変数はクラスに所属するあらゆるもので情報を共有する為にあり、
# 特異クラス定義の中でクラス変数を定義してもレキシカルに決定されます。

# 次のプログラムではクラス変数は共有されます。

# class C
#   class << self
#     @@val = 10
#   end
# end

# p C.class_variable_get(:@@val) # 10が表示される
# この問題ではクラスCの特異クラス定義をモジュールMで行っています。
# クラス変数はレキシカルに決定されますので答えは20です。

# 28問 4
v1 = 1 / 2 == 0
v2 = !!v1 or raise RuntimeError
puts v2 and false

# 選択肢
# シンタックスエラーとなる

# 選択肢
# 実行時にエラーとなる

# 選択肢
# true と表示される

# 選択肢
# false と表示される

# 1: v1 = 1 / 2 == 0
# 2: v2 = !!v1 or raise RuntimeError
# 3: puts v2 and false
# 1行目では、Fixnumクラス同士の除算はFixnumクラスになります。
# よって、0 == 0が評価され、v1はtrueになります。

# 2行目では、orは左辺が真であればその結果を返します。この時、右辺は評価されません。
# 左辺が偽であれば、右辺を評価しその結果を返します。
# また、orは評価する優先順位が低い演算子です。
# よって、優先順位が低いのでv2には!!v1の結果のtrueが入ります。
# 次に、!!v1 or raise RuntimeErrorが評価され、左辺が真であるため、左辺のみ評価されます。

# 3行目では、andは左辺が真であれば、右辺の結果を返します。左辺が偽であれば、左辺の結果を返します。
# また、andは評価する優先順位が低い演算子です。
# よって、優先順位が低いのでputs v2が評価されます。

# 演算子の優先順位を適切にするためには、括弧で式を区切ります。

# 31問 x 4
def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end

option = {arg2: 900}

foo arg1: 200, *option

# 選択肢
# 200
# 900
# と表示される

# 選択肢
# 900
# 200
# と表示される

# 選択肢
# 100
# 200
# と表示される

# 選択肢
# エラーになる

# 32問 x 4
module M
  @@val = 75

  class Parent
    @@val = 100
  end

  class Child < Parent
    @@val += 50
  end

  if Child < Parent
    @@val += 25
  else
    @@val += 30
  end
end

p M::Child.class_variable_get(:@@val)


# 選択肢
# 100と表示される

# 選択肢
# 180と表示される

# 選択肢
# 175と表示される

# 選択肢
# 150と表示される

# クラス変数はレキシカルに決定されますが、定数と同じスコープです。

module M
  CONST = 100
  @@val = 200
end

module M
  p CONST # 100 と表示されます
  p @@val # 200 と表示されます
end
# ただし、クラス変数は上位のスコープ（外側）まで探索は行いません。

module M
  CONST = 100
  @@val = 200
end

module M
  class C
    p CONST # 100 と表示されます
    p @@val # NameError
  end
end
# また、Module#<はクラスの継承関係を比較することが出来ます。
# 継承をしているように見えますが、if文では継承関係を比較しています。

# Module#<はレシーバーが引数の子孫である場合にtrueを返します。

# 問題にあるクラス変数はそれぞれ次のように計算されます。

module M
  @@val = 75

  class Parent
    @@val = 100
  end

  class Child < Parent
    @@val += 50 # @@val = 100 + 50
  end

  if Child < Parent
    @@val += 25 # @@val = 75 + 25
  else
    @@val += 30 # @@val = 75 + 30
  end
end

p M::Child.class_variable_get(:@@val)
# この問題は150が表示されます。

# 37問 x 2
module M
  def self.class_m
    "M.class_m"
  end
end

class C
  include M
end

p C.methods.include? :class_m

# 選択肢
# trueが表示される

# 選択肢
# falseが表示される

# 選択肢
# nilが表示される

# 選択肢
# 警告が表示される

# 問題コードの注意すべき点は以下の通りです。

# includeはModuleのインスタンスメソッドをMix-inするメソッドです。
# def self.class_mと宣言すると、特異クラスのメソッドになります。
# C.methodsはCの特異メソッドを表示します。
# よって、Cにはclass_mが追加されません。
