#1問目 x 4

class C
  @val = 3
  attr_accessor :val
  class << self
    @val = 10
  end
  def initialize
    @val *= 2 if val
  end
end

c = C.new
c.val += 10

p c.val

# 13と表示される

# 16と表示される

# 20と表示される

# エラーになる

# 解説

# 問題のコードは、13行目でc.valがnilになり、実行エラーになります。

# 2行目の@valはクラスインスタンス変数といい、特異メソッドからアクセスすることができます。

# 3行目の@valは特異クラスのクラスインスタンス変数です。
# この値にアクセスするためには以下のようにアクセスします。

class << C
  p @val
end
# 13行目のc.valはattr_accessorよりアクセスされます。
# initializeメソッドで初期化が行われていないため、nilが返されます。

# 以下のコードは問題コードに行番号をつけています。

#  1: class C
#  2:   @val = 3
#  3:   attr_accessor :val
#  4:   class << self
#  5:     @val = 10
#  6:   end
#  7:   def initialize
#  8:     @val *= 2 if val
#  9:   end
# 10: end
# 11:
# 12: c = C.new
# 13: c.val += 10
# 14:
# 15: p c.val

# 2問目ok 2

module M
  def class_m
    "class_m"
  end
end

class C
  include M
end

p C.methods.include? :class_m


# trueが表示される

# falseが表示される

# nilが表示される

# 警告が表示される

# 解説
# includeはModuleのインスタンスメソッドをMix-inするメソッドです。
# C.methodsはCの特異メソッドを表示します。

# よって、C#class_mはインスタンスメソッドです、C.methodsでは表示されません。

# 4問目ok 2

class C
  class << C
    def hoge
      'Hi'
    end
  end

  def hoge
    'Goodbye'
  end
end

p C.new.hoge


# 'Hi'と表示される

# 'Goodbye'と表示される

# エラーが発生する

# 'HiGoodbye'と表示される

# 解説
# 特異クラス内(class << C; end)に宣言されたメソッドは特異メソッドになります。
# また、特異メソッドはdef C.hoge: endでも宣言することができます。

# 問題のコードでは、インスタンスを作成しそのメソッドを呼び出しています。
# よって、インスタンスメソッドのGoodbyeを返すメソッドが呼ばれます。

# 8問目 ok 2

def m1(*)
  str = yield if block_given?
  p "m1 #{str}"
end

def m2(*)
  str = yield if block_given?
  p "m2 #{str}"
end

m1 m2 do
  "hello"
end

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

# 解説
# 問題のコードで使用されているメソッド類は以下の通りです。

# Kernel#block_given?はブロックが渡された場合は、真になります。
# yieldはブロックの内容を評価します。
# { }はdo endよりも結合度が高い為、実行結果に差が出ます。
# 問題のコードは以下のように解釈されます。

# m1の引数と解釈されるため、m2の戻り値はm2が表示されます。
# m1へdo .. endのブロックが渡されます。よって、m1 helloが表示されます。
m1(m2) do
  "hello"
end

# 実行結果
# "m2 "
# "m1 hello"


# 問題のコードをdo ... endで置き換えた場合は以下の実行結果になります。

m1 m2 {  # m1 (m2 { .. } ) と解釈される
  "hello"
}

# 実行結果
# m2 hello
# m1


# 9問目OK 1
module M
  def class_m
    "class_m"
  end
end

class C
  extend M
end

p C.methods.include? :class_m

# trueが表示される

# falseが表示される

# nilが表示される

# 警告が表示される

# extendは引数に指定したモジュールのメソッドを特異メソッドとして追加します。

# 問題のC.methods...は特異メソッドの一覧を取得します。

# 10問目 x 2

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

puts C.m1 # C.m1 in M と表示されます

class C
  def self.m1
    p self
  end
end

module M
  refine C.singleton_class do
    def m1
      p self
    end
  end
end

using M

puts C.m1
# C
# C と表示される


# 11問目 x 4

class C
  public
    def initialize
    end
  end

  p C.new.private_methods.include? :initialize

  # 警告が表示される

  # エラーが発生する

  # falseと表示される

  # trueと表示される


  # 12問目 x 4

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

# usingはメソッドの中で呼び出すことは出来ません。呼び出した場合はRuntimeErrorが発生します。
# `using': Module#using is not permitted in methods (RuntimeError)

# 13問目 x 4

module M
  def foo
    super
    puts "M#foo"
  end
end

class C2
  def foo
    puts "C2#foo"
  end
end

class C < C2
  def foo
    super
    puts "C#foo"
  end
  load M
end

C.new.foo

# 解説

# C2#foo
# C#foo
# M#foo
# と表示される

# C2#foo
# M#foo
# C#foo
# と表示される

# M#foo
# C2#foo
# C#foo
# と表示される

# エラーになる

# loadはrequire同様に外部ライブラリを読み込みます。

# 問題では、外部ライブラリではなく、モジュールを指定しているためエラーになります。

# load': no implicit conversion of Module into String (TypeError)


# 16問目 x14

# 次のプログラムは"Hello, world"と表示します。
# 同じ結果になる選択肢はどれですか（複数選択）

module M
  CONST = "Hello, world"
  def self.say
    CONST
  end
end

p M::say


module M
  CONST = "Hello, world"
end

module M
  def self.say
    CONST
  end
end

p M::say

module M
  CONST = "Hello, world"
end

M.instance_eval(<<-CODE)
  def say
    CONST
  end
CODE

p M::say

module M
  CONST = "Hello, world"
end

class << M
  def say
    CONST
  end
end

p M::say

module M
  CONST = "Hello, world"
end

M.module_eval(<<-CODE)
  def self.say
    CONST
  end
CODE

p M::say

解説

# 定数の定義はメモリ上にあるテーブルに管理されます。
# モジュールMを別々に書いたとしてもテーブルを参照して値を取得できます。

module M
  CONST = "Hello, world"
end

module M
  def self.say
    CONST
  end
end

p M::say
# "Hello, world"

# instance_evalの引数に文字列を指定するとネストの状態はモジュールMの特異クラスになります。
# CONSTはモジュールMにのみありますので、例外が発生します。

module M
  CONST = "Hello, world"
end

M.instance_eval(<<-CODE)
  def say
    CONST
  end
CODE

p M::say
# say': uninitialized constant #<Class:M>::CONST (NameError)

# 特異クラス定義のコンテキストでは、ネストの状態はモジュールMの特異クラスになります。
# CONSTはモジュールMにのみありますので、例外が発生します。
module M
  CONST = "Hello, world"
end

class << M
  def say
    CONST
  end
end

p M::say
# NameError (uninitialized constant #<Class:M>::CONST)

# module_evalの引数に文字列を指定するとネストの状態はモジュールMになります。
# CONSTはモジュールMにありますので値を取得できます。

module M
  CONST = "Hello, world"
end

M.module_eval(<<-CODE)
  def self.say
    CONST
  end
CODE

p M::say
# "Hello, world"


# 17問目 ok 3

class C
  CONST = "Hello, world"
end

$c = C.new

class D
  class << $c
    def say
      CONST
    end
  end
end

p $c.say

# $を@@と定数に変えることはできるが、変数、@変数はだめ

# 20問目 x 3
local = 0

p1 = lambda { |arg1, arg2|
  arg1, arg2 = arg1.to_i, arg2.to_i
  local += [arg1, arg2].max
}

p1.call("1", "2")
p1.call("7", "5")
p1.call("9")

p local

# 0が出力される

# 9が出力される

# 18が出力される

# エラーが発生する

# lambdaをcallする際の引数は省略できません。

# lambdaに似た機能にProcがあります。
# 似ていますが、異なる部分もあります。
# 次の表がlambdaとProcの違いになります。

# 特徴	Proc	lambda
# 引数の数	曖昧	厳密
# 引数の渡し方	Proc.new{\	x, y\

# return, brake, next	call以降が実行されない	call以降も実行される


#21問目 x 1

def foo(arg:)
  puts arg
end

foo 100
# ArgumentError (wrong number of arguments (given 1, expected 0; required keyword: arg))

# エラーになる

# nilと表示される

# 100と表示される

# 0と表示される

# 解説
# 問題のコードはArgumentError: missing keyword: argが発生します。

# argはキーワード引数と言います。キーワード引数は省略することができません。

# 問題のコードは次のように修正します。
def foo(arg:)
  puts arg
end

foo arg: 100


# 22問目 x

# 次のプログラムの__(1)__に適切な内容を選択して実行すると、[97, 112, 112, 108, 101]と表示されます。
# 期待した結果を得られるように正しい選択肢を選んでください。

enum_char = Enumerator.new do |yielder|
  "apple".each_char do |chr|
    # __(1)__
  end
end

array = enum_char.map do |chr|
  chr.ord
end

p array


# yielder.call chr

# yielder(chr)

# yielder << chr

# yielder.inject chr

# 解説
# mapメソッドのブロックはEnumeratorオブジェクトをレシーバーとした場合にEnumerator::Yielderオブジェクトとなります。この問題のプログラム上では変数yielderを指します。

# Enumerator::Yielderを評価するには、<<を呼び出します。
# 選択肢にある他のメソッドは実装されていません。


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

# 解説
# クラスObjectにメソッドを定義すると特異クラスでもそのメソッドを利用することが出来ます。
# 問題のプログラムを順に実行すると、答えは"5"になります。

# 補足　Object#const_succについて
# 内部でString#succ!を実行しています。このメソッドはレシーバーの文字列を次の文字列へ進めます。
# この問題ですと、"1"→"2"・・・と1ずつ繰り上がります。
# また、定数に対して行っていますが破壊的メソッドの呼び出しですので再代入にはならず警告は表示されません。

class Object
  CONST = "1"
  def const_succ
    CONST.succ!
  end
end

class Child1
  const_succ # Child1を定義した時点で"2"になっている
  class << self
    const_succ # Child1を定義した時点で"3"になっている
  end
end

class Child2
  const_succ # Child2を定義した時点で"4"になっている
  def initialize
    const_succ
  end
end

Child1.new # "4"のまま
Child2.new # "5"になる

p Object::CONST


# 26問目 ok 4

class Ca
  CONST = "001"
end

class Cb
  CONST = "010"
end

class Cc
  CONST = "011"
end

class Cd
  CONST = "100"
end

module M1
  class C0 < Ca
    class C1 < Cc
      class C2 < Cd
        p CONST

        class C2 < Cb
        end
      end
    end
  end
end


# "001"と表示される

# "010"と表示される

# "011"と表示される

# "100"と表示される

# 解説

# Rubyは定数の参照はレキシカルに決定されますが、この問題ではレキシカルスコープに定数はありません。
# レキシカルスコープに定数がない場合は、スーパークラスの探索を行います。

# この問題では、クラスC2のスコープで定数を参照しています。
# クラスC2のスーパークラスはクラスCdですので"100"が正解になります。

# 27問目

def hoge(*args, &block)
  block.call(args)
end

hoge(1,2,3,4) do |*args|
  p args.length < 0 ? "hello" : args
end

# [[1],[2],[3],[4]]と表示される

# [[1,2,3,4]]と表示される

# "hello"と表示される

# [1,2,3,4]と表示される

# 以下のコードは条件演算子といいます。条件が真の場合に、式1が返されます。条件が偽の場合に、式2が返されます。

# 条件 ? 式1 : 式2
# 問題のソースコード

# 1: def hoge(*args, &block)
# 2:   block.call(args)
# 3: end
# 4:
# 5: hoge(1,2,3,4) do |*args|
# 6:   p args.length < 0 ? "hello" : args
# 7: end
# 1行目で引数の値を配列として受け取り、ブロックに配列を渡しています。

# 5行目でブロック変数を渡していますが、*argsと宣言されているので、[[1, 2, 3, 4]]が渡されます。

# 6行目でargs.length < 0の結果は偽となり、[[1, 2, 3, 4]]が出力されます。


# 32問目 x 2

class C
  class << C
    def hoge
      'Hi'
    end
  end

  def hoge
    'Goodbye'
  end
end

p C.hoge


# 'Hi'と表示される

# 'Goodbye'と表示される

# エラーが発生する

# 'HiGoodbye'と表示される

# C.hogeはクラスメソッドを呼び出しています。
# クラスメソッドはclass << [クラス名]; end内(特異クラス)に定義したメソッドまたはdef self.[メソッド名]で定義できます。


# 34問目 ok 4

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


# 100と表示される

# 180と表示される

# 175と表示される

# 150と表示される


# 35問目 x 1

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

解説
# 問題のコードで使用されているメソッド類は以下の通りです。

# Kernel#block_given?はブロックが渡された場合は、真になります。
# yieldはブロックの内容を評価します。
# { }はdo endよりも結合度が高い為、実行結果に差が出ます。
# 問題のコードは以下のように解釈されます。

# m2へブロックが渡され、m2 helloが表示されます。
# m1へは引数が渡され、ブロックは渡されません。よって、m1が表示されます。
m1 (m2 {
      "hello"
    }
)

# 実行結果
# "m2 hello"
# "m1 "
# 問題のコードをdo endで置き換えた場合は以下の実行結果になります。

m1 m2 do  # m1(m2) do と解釈されます。
  "hello"
end

# 実行結果
# "m2 "
# "m1 hello"


# 37問目 x13

module Enumerable
  def with_prefix(prefix)
    return to_enum(__(1)__, prefix) { size } unless block_given?

    each do |char|
      yield "#{prefix} #{char}"
    end
  end
end

[1,2,3,4,5].with_prefix("Awesome").reverse_each {|char|
  puts char
}

# 実行結果
Awesome 5
Awesome 4
Awesome 3
Awesome 2
Awesome 1


# :with_prefix

# :reverse_each

# __method__

# :each


# 解説
# ブロックを渡さない場合は、Enumeratorオブジェクトを作成してメソッドをチェーン出来るようにします。

# Enumeratorオブジェクトを作成するためには、to_enumまたは、enum_forを呼びます。これらの引数にメソッド名をシンボルで指定することでチェーンした先でブロックを渡されたときにどのメソッドを評価すればよいかが分かります。

# この問題では、with_prefixを再び評価する必要がありますので、__method__または:with_prefixを引数に指定します。__method__はメソッドの中で呼び出すと、そのメソッド名になります。

def awesome_method
  __method__
end

p awesome_method # :awesome_methodとシンボルでメソッド名が分かります

# 38問目 x 4

module SuperMod
  module BaseMod
    p Module.nesting
  end
end


# [SuperMod, BaseMod]

# [SuperMod, SuperMod::BaseMod]

# [BaseMod, SuperMod]

# [SuperMod::BaseMod, SuperMod]

# 解説
# Module.nestingはネストの状態を表示します。

# 次のプログラムを実行すると、[SuperMod]と表示されます。

module SuperMod
  p Module.nesting
end
# モジュールがネストされた場合は、ネストの状態をすべて表示します。
# ネストされたモジュールはプレフィックスに外側にあるモジュールが付与されます。
# また、ネスト状態はすべて表示されますがネストが内側から順に表示されます。

module SuperMod
  p Module.nesting #=> [SuperMod]

  module BaseMod
    p Module.nesting #=> [SuperMod::BaseMod, SuperMod]

    module BaseBaseMod
      p Module.nesting #=> [SuperMod::BaseMod::BaseBaseMod, SuperMod::BaseMod, SuperMod]
    end
  end
end
# この問題では[SuperMod::BaseMod, SuperMod]が答えです。


# 39問目 x 2

p "Matz is my tEacher".scan(/[is|my]/).length


# 2と表示される

# 4と表示される

# 6と表示される

# 8と表示される


# 問題で使用されている正規表現の説明は下記の通りです。

# String#scanはマッチした部分文字列を配列で返します。
# 正規表現の[]は囲まれた*文字*1つ1つにマッチします。
# |は正規表現ではORのメタ文字です。
# 今回は、|が[]に囲まれているため、これもマッチ対象になります。
# 問題のコードでscan(/[is|my]/)が返す配列は["i", "s", "m", "y"]になります。

# 正規表現の詳しい説明はRubyリファレンスを参照してください。


# 40問目 ok 3

class S
  def initialize(*)
    puts "S#initialize"
  end
end

class C < S
  def initialize(*args)
    super
    puts "C#initialize"
  end
end

C.new(1,2,3,4,5)


# C#initialize
# と表示される

# C#initialize
# S#initialize
# と表示される

# S#initialize
# C#initialize
# と表示される

# エラーになる


# 43問目 ok 12
# 次のコードで指定した行を書き換えた時，同じ結果になるものを選べ（複数選択）

class C
  def v=(other) # ここから
    @v = other
  end
  def v
    @v
  end           # ここまで
end

c = C.new
c.v = 100
p c.v


# attr_reader :v
# attr_writer :v

# attr_accessor :v

# def v=(other)
#   v = other
# end
# def v
#   v
# end

# 該当なし


# 44問目 x 34

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



# class Array
#   def succ_each(step = 1)
#     return each(:succ_each) unless block_given?

#     each do |int|
#       yield int + step
#     end
#   end
# end

# p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

# [101, 102, 103].succ_each(5) do |succ_chr|
#   p succ_chr.chr
# end

# class Array
#   def succ_each(step = 1)
#     return to_enum(:succ_each) unless block_given?

#     each do |int|
#       yield int + step
#     end
#   end
# end

# p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

# [101, 102, 103].succ_each(5) do |succ_chr|
#   p succ_chr.chr
# end

# class Array
#   def succ_each(step = 1)
#     return to_enum(:succ_each, step) unless block_given?

#     each do |int|
#       yield int + step
#     end
#   end
# end

# p [98, 99, 100].succ_each(2).map {|succ_chr| succ_chr.chr}

# [101, 102, 103].succ_each(5) do |succ_chr|
#   p succ_chr.chr
# end

# class Array
#   def succ_each(step = 1)
#     unless block_given?
#       Enumerator.new do |yielder|
#         each do |int|
#           yielder << int + step
#         end
#       end
#     else
#       each do |int|
#         yield int + step
#       end
#     end
#   end
# end


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


# 45問目 ok 2

# lib.rbの内容
module Lib
  $num += 1
end

# program.rbの内容
$num = 0
1..10.times do |n|
  load './lib.rb'
end
puts $num


# 0と表示される

# 10と表示される

# 1と表示される

# 例外が発生する

# 解説
# loadはRubyプログラムをロードします。

# requireとloadの違い

# requireは同じファイルは1度のみロードする、loadは無条件にロードする。
# requireは.rbや.soを自動補完する、loadは補完は行わない。
# requireはライブラリのロード、loadは設定ファイルの読み込みに用いる。


# 46問目

f = Fiber.new do |total|
  Fiber.yield total + 10
end

p f.resume(100) + f.resume(5)


# 110と表示される

# 105と表示される

# 15と表示される

# 115と表示される

Fiber#resumeを実行するとFiber.yieldが最後に実行された行から再開するか、Fiber.newに指定したブロックの最初の評価を行います。

サンプルプログラムを実行して、処理の内容を見てみましょう。

f = Fiber.new do |name|
  Fiber.yield "Hi, #{name}"
end

# p f.resume('Matz') # 'Hi, Matz'と表示されます。
# f.resume('Matz')を実行する。
# Fiber.newのブロックを評価し、引数nameには'Matz'をセットする。
# 変数を展開して、'Hi, Matz'をFiber.yieldの引数にセットする。
# Fiber.yield('Hi, Matz')を実行すると、f.resume('Matz')の戻り値が'Hi, Matz'になる。
# Fiber.yield('Hi, Matz')の実行終了を待たずに、プログラムが終了する。
# 問題では、Fiber#resumeを２回実行していますが処理の順序は同じです。

f = Fiber.new do |total|
  Fiber.yield total + 10
end

# p f.resume(100) + f.resume(5)
# f.resume(100)を実行する。
# Fiber.newのブロックを評価し、引数totalには100をセットする。
# 100 + 10を計算して110をFiber.yieldの引数にセットする。
# Fiber.yield(110)を実行すると、f.resume(100)の戻り値が110になる。
# f.resume(5)を実行する。
# Fiber.yield(110)から処理を再開し、戻り値が5になる。
# ブロックの最終行になったので、f.resume(5)の戻り値が5になる。
# 110 + 5を評価して、115が画面に表示される。
# この問題のプログラムを実行すると、115が表示されます。

# 50問目

characters = ["a", "b", "c"]

characters.each do |chr|
  chr.freeze
end

upcased = characters.map do |chr|
  chr.upcase
end

p upcased


# 例外が発生する

# ["a", "b", "c"]と表示される

# ["A", "B", "C"]と表示される

# ["d", "e", "f"]と表示される

# 解説
# freezeはオブジェクトの破壊的な変更を禁止します。

# char = "a"
# char.freeze
# p char.upcase! # 例外発生
# 問題では配列の各要素を破壊的な変更を禁止しています。さらにその要素をupcaseで大文字に変換していますが、破壊的な変更ではないため例外は発生しません。

# ["A", "B", "C"]がこの問題の答えです。
