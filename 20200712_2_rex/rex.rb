
# 2問目 x 2 3

# 次のプログラムは"Hello, world"と表示します。
# 同じ結果になる選択肢はどれですか（複数選択）

module M
  CONST = "Hello, world"

  class C
    def awesome_method
      CONST
    end
  end
end

p M::C.new.awesome_method



# module M
#   CONST = "Hello, world"
# end
# class M::C
#   def awesome_method
#     CONST
#   end
# end
# p M::C.new.awesome_method



# class C
# end
# module M
#   CONST = "Hello, world"
#   C.class_eval do
#     def awesome_method
#       CONST
#     end
#   end
# end
# p C.new.awesome_method

# class C
#   CONST = "Hello, world"
# end
# module M
#   C.class_eval(<<-CODE)
#     def awesome_method
#       CONST
#     end
#   CODE
# end
# p C.new.awesome_method

# class C
#   CONST = "Hello, world"
# end
# module M
#   C.class_eval do
#     def awesome_method
#       CONST
#     end
#   end
# end
# p C.new.awesome_method

# 解説
# 定数の参照はレキシカルに行われます。
# M::C#awesome_methodのコンテキストにCONSTがないため例外が発生します。

module M
  CONST = "Hello, world"
end

class M::C
  def awesome_method
    CONST
  end
end

p M::C.new.awesome_method

# class_evalにブロックを渡した場合は、ブロック内のネストはモジュールMになります。
# そのコンテキストから定数を探しますので"Hello, world"が表示されます。

class C
end

module M
  CONST = "Hello, world"

  C.class_eval do
    def awesome_method
      CONST
    end
  end
end

p C.new.awesome_method

# class_evalに文字列を渡した場合のネストの状態はクラスCです。
# CONSTはクラスCにありますので"Hello, world"が表示されます。

class C
  CONST = "Hello, world"
end

module M
  C.class_eval(<<-CODE)
    def awesome_method
      CONST
    end
  CODE
end

p C.new.awesome_method

# class_evalにブロックを渡した場合は、ブロック内のネストはモジュールMになります。
# そのコンテキストから定数を探しますがないため例外が発生します。

class C
  CONST = "Hello, world"
end

module M
  C.class_eval do
    def awesome_method
      CONST
    end
  end
end

p C.new.awesome_method


# 4問目 x 1

class S
  @@val = 0
  def initialize
    @@val += 1
  end
end

class C < S
  class << C
    @@val += 1
  end

  def initialize
  end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)

# 3と表示される

# 4と表示される

# 5と表示される

# 2と表示される

# C#initializeがS#initializeをオーバーライドされているため、@@val += 1は実行されません。
# class << C ~ endの処理はクラスを定義した時点で、実行されます。


# 7問目 x 1

class C
  def self.m1
    200
  end
end

module R
  refine C.singleton_class do
    def m1
      100
    end
  end
end

using R

puts C.m1


# 100と表示される

# 200と表示される

# 300と表示される

# エラーが発生する

# Module#refineは無名のモジュールを作成します。ブロック内のselfは無名モジュールになります。

class C
end

module M
  refine C do
    self # 無名モジュールを指します
  end
end
# Refinementでクラスメソッドを再定義する場合は次のようにsingleton_classを使います。ブロックの中でself.m1としないのがポイントです。

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

puts C.m1 # C.m1 in M と表示されます。
# この問題では、クラスメソッドは再定義していますので100が表示されます。


# 9問目 x 1

val = 1 + 1/2r
puts val.class


# Rationalと表示される

# Fixnumと表示される

# NilClassと表示される

# エラーになる

# 1/2rはRationalのインスタンスが作成されます。
# FixnumとRationalの演算はRationalになります。
# (Ruby 2.4からFixnumとBignumが統合されIntegerになりました)

# その他のクラス演算を以下にまとめます。

# 演算	戻り値クラス
# FixnumとRationalの演算	Rational
# FloatとRationalの演算	Float
# FixnumとComplexの演算	Complex
# FloatとComplexの演算	Complex
# Date同士の減算	Rational
# Time同士の減算	Float
# DateTime同士の減算	Rational


# 19問目 x

class C
  def m1
    200
  end
end

module R
  refine C do
    def m1
      300
    end
  end
end

using R

class C
  def m1
    100
  end
end

puts C.new.m1


# 100と表示される


# 200と表示される


# 300と表示される


# エラーが発生する

# Refinementで再定義したメソッドの探索ですが、prependより優先して探索が行われます。
# 例えば、クラスCはクラスBを継承しているとすると次のような順に探索を行います。
# Refinement -> prependしたモジュール -> クラスC -> includeしたモジュール -> クラスCの親（クラスB）

# 問題ではusingの後にクラスオープンしてメソッドを再定義していますが、Refinementにある300が表示されます。


# 23問目 x 4
# 次のプログラムを実行するとどうなりますか

class Base
  CONST = "Hello, world"
end

class C < Base
end

module P
  CONST = "Good, night"
end

class Base
  prepend P
end

module M
  class C
    CONST = "Good, evening"
  end
end

module M
  class ::C
    def greet
      CONST
    end
  end
end

p C.new.greet

# 例外が発生する

# "Good, night"と表示される

# "Good, evening"と表示される

# "Hello, world"と表示される

# 解説
# ::演算子が先頭にあるとトップレベルから定数の探索を行います。
# モジュールMにあるクラスCはトップレベルにあるものを指します。

# greetメソッドにあるCONSTはクラスCにはありませんが、スーパークラスにあるか探索を行います。
# クラスBaseを継承していますので、"Hello, world"が表示されます。


# 25問目 x 4

m = Module.new

CONST = "Constant in Toplevel"

_proc = Proc.new do
  CONST = "Constant in Proc"
end

m.module_eval(<<-EOS)
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

m.module_eval(&_proc)

p m.const

# 例外が発生する

# "Constant in Module instance"と表示される

# "Constant in Proc"と表示される

# "Constant in Module instance"と表示される

# 解説
# メソッドconstは特異クラスで定義されていないので、例外が発生します。
# constメソッドを実行したい場合は次のようにmodule_functionまたはinstance_evalを使う必要があります。

m.module_eval(<<-EOS) # module_eval のまま
  CONST = "Constant in Module instance"

  def const
    CONST
  end

  module_function :const # module_function にシンボルでメソッドを指定する
EOS
m.instance_eval(<<-EOS) # instance_eval で特異クラスにメソッドを定義する
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

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




# 35問目 x 4
# 以下のコードを実行するとどうなりますか

class C
protected
  def initialize
  end
end

p C.new.methods.include? :initialize


# 警告が表示される

# エラーが発生する

# falseと表示される

# trueと表示される

# protectedメソッドは仲間クラス(自クラスかサブクラスのレシーバー)へ公開されているが、それ以外のクラスには隠蔽されています。
# 仲間クラスから参照するために、メソッドとしては公開されています。



# 36問目 おそらく1,2,4
# 実行してもエラーにならないコードを選べ


def bar(&block)
  block.yield
end
bar do
  puts "hello, world"
end


def bar(&block)
  block.call
end
bar do
  puts "hello, world"
end


def bar(&block, n)
  block.call
end
bar(5) {
  puts "hello, world"
}


def bar(n, &block)
  block.call
end
bar(5) {
  puts "hello, world"
}

# 解説
# 引数名に&を付与することでブロック引数になります。
# ブロック引数は他の引数より後に記述します。


# 38問目 3

class Class
  def method_missing(id, *args)
    puts "Class#method_missing"
  end
end
class A
  def method_missing(id, *args)
    puts "A#method_missing"
  end
end
class B < A
  def method_missing(id, *args)
    puts "B#method_missing"
  end
end

B.dummy_method


# エラーになる

# A#method_missing

# Class#method_missing

# B#method_missing


# 解説
# method_missingは、継承チェーンを辿った末にメソッドが見つからなかった場合に、呼び出されます。
# method_missingも継承チェーンを辿ります。

# 問題で、B.dummy_methodと呼び出しています。
# これは、Classクラスのインスタンスメソッドが呼ばれます。
# よって、Class#method_missingが出力されます。
