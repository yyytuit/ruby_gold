# 7問目 x 1

def hoge(&block, *args)
  block.call(*args)
end

hoge(1,2,3,4) do |*args|
  p args.length > 0 ? "hello" : args
end

# エラーが発生する

# "hello"と表示される

# 警告が表示される

# [1,2,3,4]と表示される

# 解説
# ブロック引数は仮引数の中で最後に記述します。


# 16問目 ok 1

def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end

option = {arg2: 900}

foo arg1: 200, **option

# 200
# 900
# と表示される

# 900
# 200
# と表示される

# 100
# 200
# と表示される

# エラーになる

# 解説
# キーワード引数へHashオブジェクトを渡すことができます。
# Hashの中身を渡す必要があるので、変数の前に**を付加します。


# 18問目 x 3

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

# 解説
# @@valに1加算しているタイミングは以下です。

# Cクラスの特異クラスを定義
# C.newの呼び出し
# S.newの呼び出し

# 19問目 x 1

d = Date.today - Date.new(2015,10,1)
p d.class


# Rationalと表示される

# Fixnumと表示される

# Bignumと表示される

# Complexと表示される

# Dateクラス同士の減算はRationalになります。

# その他、似たクラスの演算を以下にまとめます。

# 演算	戻り値クラス
# Date同士の減算	Rational
# Time同士の減算	Float
# DateTime同士の減算	Rational


# 23問目 x 4

def foo(n)
  n ** n
end

foo = Proc.new { |n|
  n * 3
}

puts foo[2] * 2


# 8と表示される

# 256と表示される

# 16777216と表示される

# 12と表示される

# 解説
# メソッドと変数の探索順位は変数が先です。

# Procはcallまたは[]で呼び出すことができます。

# 問題では、foo[2]と宣言されているため、探索順の早いProcオブジェクトが呼び出されます。
# もし、foo 2と宣言された場合は、メソッドが選択されます。
# ex foo 2 * 2 -> 256
# ex foo(2) * 2 -> 8

# 27問目 ok 1

class Integer
  def +(other)
    self.-(other)
  end
end

p 1 + 1


# 2と表示される

# 0と表示される

# nilと表示される

# 3と表示される

# 解説
# 数値はFixnumクラスのオブジェクトです。FixnumクラスはIntegerクラスのサブクラスです。

# 問題では、Integerクラスへ+メソッドをオープンクラスし、オーバーロードているように取れます。
# しかし、+メソッドはFixnumクラスで定義されています。
# よって、元のFixnum#+が呼ばれます。

p 1.class.ancestors           #=> [Fixnum, Integer, Numeric, Comparable, Object, Kernel, BasicObject]
p Numeric.method_defined?(:+) #=> false
p Integer.method_defined?(:+) #=> false
p Fixnum.method_defined?(:+)  #=> true

# 解説のとおりだと答えは2になる。
# ただし最新のrubyのバージョンだと以下になる
1.class.ancestors   # => [Integer, Numeric, Comparable, Object, Kernel, BasicObject]
Numeric.method_defined?(:+)  # => false
Integer.method_defined?(:+)  # => true
Fixnum.method_defined?(:+)   # => true
#となるので答えは0になる


# 37問目 ok 4

require 'singleton'

class Message
  include Singleton

  def morning
    'Hi, good morning!'
  end
end

p Message.__(1)__.morning

# 期待値

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


# 40問目 x

次のコードの実行結果がfalsetrueになるようにXXXX,YYYYに適切なコードを選択せよ

class Company
  XXXX
  attr_reader :id
  attr_accessor :name
  def initialize id, name
    @id = id
    @name = name
  end
  def to_s
    "#{id}:#{name}"
  end
  YYYY
end

c1 = Company.new(3, 'Liberyfish')
c2 = Company.new(2, 'Freefish')
c3 = Company.new(1, 'Freedomfish')

print c1.between?(c2, c3)
print c2.between?(c3, c1)



# XXXX
# include Comparable

# YYYY
# def <=> other
#   self.id <=> other.id
# end


# XXXX
# extend Comparable

# YYYY
# def <=> other
#   other.id <=> self.id
# end

# XXXX
# include Sortable

# YYYY
# def <=> other
#   self.id <=> other.id
# end

# XXXX
# extend Sortable

# YYYY
# def <=> other
#   other.id <=> self.id
# end

# between?で値を比較するためには、Comparableをincludeする必要があります。

# Comparableは比較に<=>を使用しています。
# 自作クラスの場合はオブジェクトIDが比較対象となります。
# 通常は、Comparable#<=>をオーバーライドします。

# Fixnum#<=>(other)は以下の結果を返します。

# selfがotherより大きい場合は、1を返します。
# selfがotherと等しい場合は、0を返します。
# selfがotherより小さい場合は、-1を返します。
# extendはモジュールのインスタンスメソッドを特異メソッドとして追加します。
# インスタンス変数からメソッドを参照することができなくなるので、エラーになります。

# Sortableモジュールは存在しません。

42問目 x 4

m = Module.new

CONST = "Constant in Toplevel"

_proc = Proc.new do
  CONST = "Constant in Proc"
end

m.instance_eval(<<-EOS)
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

m.module_eval(&_proc)

p m.const

# 例外が発生する

# "Constant in Toplevel"と表示される

# "Constant in Proc"と表示される

# "Constant in Module instance"と表示される

# メソッドconstは特異クラスで定義されていますので、実行することができます。
# その中で参照している定数CONSTはレキシカルに決定されますので、"Constant in Module instance"が表示されます。

# instance_evalはブロックを渡す場合と、文字列を引数とする場合でネストの状態が異なります。
# ブロックを渡した場合はネストは変わりませんが、文字列を引数とした場合は期待するネストの状態になります。ネストが変わらない状態で定数の代入を行うと、再代入になり警告が表示される場合があります。
# 例えば、次のプログラムではmodule_evalに文字列を引数とするとモジュールを再オープン、または定義したネストと同じです。

module M
  p Module.nesting # [M]
end

M.module_eval(<<-EVAL)
  p Module.nesting # [M]
EVAL

M.instance_eval do
  p Module.nesting # []
end

module M
  p Module.nesting # [M]
end



# 43問目 x 3

mod = Module.new

mod.module_eval do
  EVAL_CONST = 100
end

puts "EVAL_CONST is defined? #{mod.const_defined?(:EVAL_CONST, false)}"
puts "EVAL_CONST is defined? #{Object.const_defined?(:EVAL_CONST, false)}"


# EVAL_CONST is defined? false
# EVAL_CONST is defined? false

# EVAL_CONST is defined? true
# EVAL_CONST is defined? false

# EVAL_CONST is defined? false
# EVAL_CONST is defined? true

# EVAL_CONST is defined? true
# EVAL_CONST is defined? true

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

# 出力結果
# BLOCK: CONST is defined? false
# BLOCK: CONST is defined? true
# HERE_DOC: CONST is defined? true
# HERE_DOC: CONST is defined? false

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


# 44問目 x 3
# 次のプログラムで例外FiberErrorが発生する、Fiber#resumeの組み合わせを選択肢から選んでください。
f = Fiber.new do
  Fiber.yield 15
  5
end


# f.resume

# f.resume
# f.resume
# f.resume

# f.resume
# f.resume

# f.resume
# f.resume
# f.resume
# f.resume

# 解説
# Fiberは軽量スレッドを提供します。

# Fiber#resumeを実行するとFiber.yieldが最後に実行された行から再開するか、Fiber.newに指定したブロックの最初の評価を行います。

# サンプルプログラムを実行して、処理の内容を見てみましょう。

f = Fiber.new do |name|
  Fiber.yield "Hi, #{name}"
end

p f.resume('Matz') # 'Hi, Matz'と表示されます。
p f.resume('Akira') # 'Akira'と表示されます。
p f.resume('Steve') # FiberErrorが発生します。
f.resume('Matz')を実行する。

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

f.resume
f.resume
f.resume
# または、

f.resume
f.resume
f.resume
f.resume
# がこの問題の答えになります。


# 46問目 x 13

require 'json'

json = <<JSON
{
  "price":100,
  "order_code":200,
  "order_date":"2018/09/20",
  "tax":0.8
}
JSON

hash = __(1)__
p hash

# 期待値

{"price"=>100, "order_code"=>200, "order_date"=>"2018/09/20", "tax"=>0.8}


# JSON.load json

# JSON.save json

# JSON.parse json

# JSON.read json

# JSON形式の文字列をHashオブジェクトにするメソッドを選ぶ必要があります。

# JSON.loadまたは、JSON.parseは引数にJSON形式の文字列を指定するとHashオブジェクトに変換します。

require 'json'

json = <<JSON
{
  "price":100,
  "order_code":200,
  "order_date":"2018/09/20",
  "tax":0.8
}
JSON

using_parse = JSON.parse json
p using_parse

using_load = JSON.load json
p using_load


# 47問目 x 3

class Base
  def name
    p 'Base#name'
  end
end

module Scope
  class Base
    def name
      p 'Scope::Base#name'
    end
  end

  class Inherited < Base
    def name
      p 'Scope::Inherited#name'
      super
    end
  end
end

inherited = Scope::Inherited.new
inherited.name


# "Scope::Base#name"
# "Scope::Inherited#name"

# "Base#name"
# "Scope::Base#name"

# "Scope::Inherited#name"
# "Scope::Base#name"

# "Scope::Inherited#name"
# "Base#name"
