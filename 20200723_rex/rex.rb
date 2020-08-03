#8問 ok 2
module M
  def method_missing(id, *args)
    puts "M#method_missing"
  end
end
class A
  include M
  def method_missing(id, *args)
    puts "A#method_missing"
  end
end
class B < A
  class << self
    def method_missing(id, *args)
      puts "B.method_missing"
    end
  end
end

B.new.dummy_method


# エラーになる

# A#method_missing

# M#method_missing

# B.method_missings

# 解説
# method_missingは、継承チェーンを辿った末にメソッドが見つからなかった場合に、呼び出されます。
# method_missingも継承チェーンを辿ります。

# class << self; endで定義されたメソッドは、特異クラスのインスタンスメソッドになります。
# 特異クラスの呼び出しは一番最後
# よって、B.method_missingではなく、A#method_missingが出力されます。

#10問 x 2
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

# 100と表示される

# 200と表示される

# 300と表示される

# エラーが発生する

# 解説
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

# puts C.m1 # C.m1 in M と表示されます。
# この問題では、クラスメソッドは再定義していませんので200が表示されます。


# 11問 x 4

class C
end

module M
  refine C do
    def m1
      100
    end
  end
end

class C
  def m1
    400
  end

  def self.using_m
    using M
  end
end

C.using_m

puts C.new.m1

# 100と表示される

# 200と表示される

# 300と表示される

# エラーが発生する

# 解説
# usingはメソッドの中で呼び出すことは出来ません。呼び出した場合はRuntimeErrorが発生します。

# 12問 x 4

module M
  def refer_const
    CONST
  end
end

module E
  CONST = '010'
end

class D
  CONST = "001"
end

class C < D
  include E
  include M
  CONST = '100'
end

c = C.new
p c.refer_const


# "001"と表示される

# "010"と表示される

# "100"と表示される

# 例外が発生する

# refer_constはモジュールMにありますが、CONSTはレキシカルに決定されるためモジュールMのスコープを探索します。
# この問題ではCONSTが見つからないため例外が発生します。

# 15問 ok 2
def hoge(*args, &block)
  block.call(*args)
end

hoge(1,2,3,4) do |*args|
  p args.length > 0 ? "hello" : args
end

# エラーが発生する

# "hello"と表示される

# 警告が表示される

# [1,2,3,4]と表示される

解説
# 以下のコードは条件演算子といいます。条件が真の場合に、式1が返されます。条件が偽の場合に、式2が返されます。

# 条件 ? 式1 : 式2
# 問題のソースコード

# 1: def hoge(*args, &block)
# 2:   block.call(*args)
# 3: end
# 4:
# 5: hoge(1,2,3,4) do |*args|
# 6:   p args.length > 0 ? "hello" : args
# 7: end
# 1行目で引数の値を配列として受け取り、ブロックに配列を渡しています。

# 2行目で*を付けて引数を渡しているので、配列が展開されます(1, 2, 3, 4)。

# 5行目でブロック変数を渡していますが、*argsと宣言されているので、[1, 2, 3, 4]が渡されます。

# 6行目でargs.length > 0の結果は真となり、helloが出力されます。

# 17問 ok 3
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

# module_evalに文字列を引数とした場合は、レシーバーのスコープで評価されます。
# 問題のプログラムを次のようにするとネストの状態を調べることができます。

# A.module_eval(<<-CODE)
#   p Module.nesting # [A]と表示され、モジュールAのスコープにあることがわかる
# CODE
# 定数は静的に探索が行われますので、A::Bの42が答えになります。

21問 x 4

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

# ::演算子が先頭にあるとトップレベルから定数の探索を行います。
# モジュールMにあるクラスCはトップレベルにあるものを指します。

# greetメソッドにあるCONSTはクラスCにはありませんが、スーパークラスにあるか探索を行います。
# クラスBaseを継承していますので、"Hello, world"が表示されます。


# 22問 x 3

class Object
  CONST = "1"
  def const_succ
    CONST.succ!
  end
end

class Child1
  const_succ
  class << self
    const_succ
  end
end

class Child2
  const_succ
  def initialize
    const_succ
  end
end

Child1.new
Child2.new

p Object::CONST

# "3"と表示される

# "4"と表示される

# "5"と表示される

# "6"と表示される

# クラスObjectにメソッドを定義すると特異クラスでもそのメソッドを利用することが出来ます。
# 問題のプログラムを順に実行すると、答えは"5"になります。

# 補足　Object#const_succについて
# 内部でString#succ!を実行しています。このメソッドはレシーバーの文字列を次の文字列へ進めます。
# この問題ですと、"1"→"2"・・・と1ずつ繰り上がります。
# また、定数に対して行っていますが破壊的メソッドの呼び出しですので再代入にはならず警告は表示されません。

# 23問 x 4

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

# module_evalにブロックを渡した場合のネストは次の通りです。

# A.module_eval do
#   p Module.nesting # []と表示され、ネストされた状態になく、トップレベルにいることがわかる
# end
# トップレベルで定数を定義した場合はObjectの定数になります。

# B = "Hello, world"
# p Object.const_get(:B) # "Hello, world"と表示される
# 問題にあるメソッドA.fはトップレベルにある定数を探索するため答えは15になります。


# 25問 x 2

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

28問 ok 1

def m1(*)
  str = yield if block_given?
  p "m1 #{str}"
end

def m2(*)
  str = yield if block_given?
  p "m2 #{str}"
end

m1 m2 {
  "hello"
}

# "m2 hello"
# "m1 "
# と表示される


# "m2 "
# "m1 hello"
# と表示される


# "m2 "
# "m1 "
# と表示される


# 警告が表示される

# 問題のコードで使用されているメソッド類は以下の通りです。

# Kernel#block_given?はブロックが渡された場合は、真になります。
# yieldはブロックの内容を評価します。
# { }はdo endよりも結合度が高い為、実行結果に差が出ます。
# 問題のコードは以下のように解釈されます。

# m2へブロックが渡され、m2 helloが表示されます。
# m1へは引数が渡され、ブロックは渡されません。よって、m1が表示されます。
# m1 (m2 {
#       "hello"
#     }
# )

# # 実行結果
# # "m2 hello"
# # "m1 "
# 問題のコードをdo endで置き換えた場合は以下の実行結果になります。

# m1 m2 do  # m1(m2) do と解釈されます。
#   "hello"
# end

# # 実行結果
# # "m2 "
# # "m1 hello"

32問 x 1,2,4

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

  # 引数名に&を付与することでブロック引数になります。
  # ブロック引数は他の引数より後に記述します。

# 35問 x 1
class C
end

module M
  refine C do
    def m1(value)
      super value - 100
    end
  end
end

class C
  def m1(value)
    value - 100
  end
end

using M

class K < C
  def m1(value)
    super value - 100
  end
end

puts K.new.m1 400

# 100と表示される

# 200と表示される

# 300と表示される

# 400と表示される

# superを実行した場合にもRefinementが影響します。理解しやすいようにそれぞれのメソッドにコメントと計算の途中結果を追加しました。

class C
end

module M
  refine C do
    def m1(value)
      p "define m1 using Refinement"
      super value - 100 # 300 - 100
    end
  end
end

class C
  def m1(value)
    p "define m1 in C"
    value - 100 # 200 - 100
  end
end

using M # ここからRefinementが有効になる

class K < C
  def m1(value)
    p "define m1 in K"
    super value - 100 # 400 - 100
    # Refinementが有効なのでsuperはモジュールMにあるm1を参照する
  end
end

puts K.new.m1 400
# プログラムを実行するとコメントは次の順に表示されます。

"define m1 in K"
"define m1 using Refinement"
"define m1 in C"
# superを実行したクラスの親クラスにRefinemnetがあれば同名のメソッドを探索して実行します。
# さらに、Refinementのなかでsuperを実行するとRefinementの対象クラスのメソッドを探索します。

# 41問 x 4
require 'singleton'

class Message
  include Singleton

  def morning
    'Hi, good morning!'
  end
end

p Message.__(1)__.morning
期待値

'Hi, good morning!'

# instantize

# object

# singleton

# instance

# Singletonモジュールをインクルードすると、クラスメソッドinstanceを定義します。

# このメソッドを呼び出すことでクラスのインスタンスを１つだけ返します。

require 'singleton'

class Message
  include Singleton

  def morning
    'Hi, good morning!'
  end
end

p Message.instance.__id__ # 70163722811160
p Message.instance.__id__ # 70163722811160
# オブジェクトIDがすべて同じ値を返していることから、インスタンスが１つだけ返していることがわかる。
# 選択肢にあるinstantize、object、singletonはSingletonモジュールをインクルードしても定義されません。


# 45問 ok 3 4
次のプログラムと同じ実行結果が得られる実装を選択肢から選んでください。

class Array
  def succ_each(step = 1)
    return enum_for(:succ_each, step) unless block_given?

    each do |int|
      yield int + step
    end
  end
end

p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

[101, 102, 103].succ_each(5) do |succ_chr|
  p succ_chr.chr
end
# 実行結果
["d", "e", "f"]
"j"
"k"
"l"


class Array
  def succ_each(step = 1)
    return each(:succ_each) unless block_given?

    each do |int|
      yield int + step
    end
  end
end
p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}
[101, 102, 103].succ_each(5) do |succ_chr|
  p succ_chr.chr
end


class Array
  def succ_each(step = 1)
    return to_enum(:succ_each) unless block_given?

    each do |int|
      yield int + step
    end
  end
end
p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}
[101, 102, 103].succ_each(5) do |succ_chr|
  p succ_chr.chr
end

class Array
  def succ_each(step = 1)
    return to_enum(:succ_each, step) unless block_given?
    each do |int|
      yield int + step
    end
  end
end
p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}
[101, 102, 103].succ_each(5) do |succ_chr|
  p succ_chr.chr
end

class Array
  def succ_each(step = 1)
    unless block_given?
      Enumerator.new do |yielder|
        each do |int|
          yielder << int + step
        end
      end
    else
      each do |int|
        yield int + step
      end
    end
  end
end

# 解説
# ブロックを渡す場合と、チェーンを行う場合の両方を考慮する必要があります。
# チェーンを行う場合はEnumeratorオブジェクトを作成する必要があります。作成に必要なメソッドはenum_forとto_enumです。

# 問題では、enum_forを使っていますので選択肢のうちto_enumを使っている選択肢が答えのひとつです。
# ただし、to_enumは引数にメソッド名とそのメソッドに必要な引数を指定する必要があります。問題ではsucc_eachメソッドに引数2を渡していますのでEnumeratorオブジェクトを作成するときに必要になります。

# また、Enumeratorオブジェクトはnewメソッドで作成することが出来ます。この問題ですと少し冗長ではありますが、全体的には次のとおりです。

class Array
  def succ_each(step = 1)
    unless block_given? # ブロックが無い場合は、オブジェクトを作成
      Enumerator.new do |yielder|
        each do |int|
          yielder << int + step
        end
      end
    else # ブロックがある場合の実装
      each do |int|
        yield int + step
      end
    end
  end
end
# これも答えのひとつで、この問題ではto_enum(:succ_each, step)とEnumeratorオブジェクトを作成する選択肢が答えになります。

# なお、チェーンした先で渡されたブロックを評価するためにはEnumerator::Yielderのオブジェクトを利用します。
# オブジェクトに対して、<<を実行することでブロック内で評価した結果を受け取ることが出来ます。

46問 x 234

次のプログラムと同じ結果になる選択肢を選んでください。

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

# モジュールにクラスメソッドを定義するには３つ方法があります。
# この問題の答えは次のとおりです。

module M
  extend self
  def a
    100
  end
end

p M.a
module M
  def a
    100
  end

  module_function :a
end

p M.a
module M
  class << self
    def a
      100
    end
  end
end

p M.a


# 50問 x 24
# 次のプログラムで例外FiberErrorが発生する、Fiber#resumeの組み合わせを選択肢から選んでください。

f = Fiber.new do
  Fiber.yield 15
  5
end

# 選択肢
f.resume
# 選択肢
f.resume
f.resume
f.resume
# 選択肢
f.resume
f.resume
# 選択肢
f.resume
f.resume
f.resume
f.resume

# Fiberは軽量スレッドを提供します。

# Fiber#resumeを実行するとFiber.yieldが最後に実行された行から再開するか、Fiber.newに指定したブロックの最初の評価を行います。

# サンプルプログラムを実行して、処理の内容を見てみましょう。

f = Fiber.new do |name|
  Fiber.yield "Hi, #{name}"
end

p f.resume('Matz') # 'Hi, Matz'と表示されます。
p f.resume('Akira') # 'Akira'と表示されます。
p f.resume('Steve') # FiberErrorが発生します。
# f.resume('Matz')を実行する。
# Fiber.newのブロックを評価し、引数nameには'Matz'をセットする。
# 変数を展開して、'Hi, Matz'をFiber.yieldの引数にセットする。
# Fiber.yield('Hi, Matz')を実行すると、f.resume('Matz')の戻り値が'Hi, Matz'になる。
# Fiber.yield('Hi, Matz')は終了せず、次のf.resume('Akira')の実行を待つ。
# f.resume('Akira')を実行するとFiber.yield('Hi, Matz')の戻り値が'Akira'になる。
# ブロックの最終行なので、'Akira'がf.resume('Akira')の戻り値になる。
# 問題の処理の内容は次のとおりです。

f = Fiber.new do
  Fiber.yield 15
  5
end

f.resume
f.resume
f.resume
f.resume
# １行目のf.resumeを実行する。
# Fiber.newのブロックを評価する。
# Fiber.yield(15)を実行すると、１行目のf.resumeの戻り値が15になる。
# Fiber.yield(15)は終了せず、次の２行目のf.resumeの実行を待つ。
# ２行目のf.resumeを実行すると、Fiber.yield(15)の戻り値がnilになる。
# なお、Fiber#resumeに引数なしで実行すると、Fiber.yieldの戻り値はnilになります。
# 処理を次の行に移り、ブロック最終行の5が２行目のf.resumeの戻り値になります。
# ３行目のf.resumeを実行するが、ブロックの評価が終わっているので例外FiberErrorが発生します。
# この問題の答えは、３回以上呼び出す
