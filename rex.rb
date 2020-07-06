'1問目 正解は 1234 OK'

while not DATA.eof? #`File#eof?`はファイルの終わりまで読み込んだかを返します。
  lines = DATA.readlines # `File#readlines`はファイルから全て読み込みます。内容は各行を要素にもつ配列になります。
  lines.map(&:chomp!) #`lines`の中身を`chomp!`で破壊的に末尾の改行を取り除きます。
  lines.reverse #`reverse`は配列の内容を逆順にします。このメソッドは破壊的メソッドではないため、`self`の内容は変わりません。
  p lines
end
#__END__はRubyスクリプトの終わりを表します。
#__END__以降の文字列は組み込み定数DATAに入ります。
# 1問目はEND~4までのコメントアウトを外すこと
#__END__
#1
#2
#3
#4

'2問目 正解は12 X'

p (1..10).lazy.map{|num| # lazyは遅延評価で#<Enumerator::Lazy: #<Enumerator::Lazy: 1..10>:map>にするのだが、結果の出力には関係ない。
  num * 2
}.take(3).inject(0, &:+) # takeで最初の3つをとる。2、４、６
#injectで0を指定して、0+2それを記憶しながらどんどんたすので、2+4、最後に6+6となり答えは12

'3問目 X 正解は2,3'
'選択肢1は不正解'

module M
  CONST = "Hello, world"
end

class M::C
  def awesome_method
    CONST
  end
end

p M::C.new.awesome_method
# NameError (uninitialized constant M::C::CONST)

'選択肢2は正解'

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
# class_evalをにブロックを渡すことで、Cクラスにawesome_methodメソッドを定義したかのように見せることができる。なのでmodule M内でCクラスにawesome_methodを定義し、 modudleMで定義したCONSTを呼び出している。

'選択肢3は正解'

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

# class_evalに文字列を渡した場合のネストの状態はクラスCです。
# CONSTはクラスCにありますので"Hello, world"が表示されます。

'選択肢4は不正解'

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
# module MにCONSTを定義してないので不正解
# NameError (uninitialized constant M::CONST)
# class_evalにブロックを渡した場合は、ブロック内のネストはモジュールMになります。
# そのコンテキストから定数を探しますがないため例外が発生します。

#つまりclass evalはブロックを渡すか文字列を渡すかでネストが変わる。

'4問目 正解100 OK'

class C
  def m1
    200
  end
end

module R
  refine C do
    def m1
      100
    end
  end
end

using R

c = C.new
puts c.m1

#RefinementはModule#refineを呼び出すことで定義することが出来ます。
#Module#usingで定義したRefinementを有効化することができます。

'5問目 正解は18 OK'

local = 0

p1 = Proc.new { |arg1, arg2|
  arg1, arg2 = arg1.to_i, arg2.to_i
  local += [arg1, arg2].max
}

p1.call("1", "2")
p1.call("7", "5")
p1.call("9")

p local


'6問目 正解は011 X'

module M1
  class C1
    CONST = "001"
  end

  class C2 < C1
    CONST = "010"

    module M2
      CONST = "011"

      class Ca
        CONST = "100"
      end

      class Cb < Ca
        p CONST
      end
    end
  end
end

#また、使われている定数の場所がネストされている場合は内側から順に定数の探索が始まります。
#レキシカルスコープに定数がない場合は、スーパークラスの探索を行います。
#クラスCbから最も物理的に近いのはM2::CONSTであるため答えは"011"になります。
#スーパークラスの探索はこの場合には行われません。


'9問目 正解はYukichi x'

class Human
  NAME = "Unknown"

  def self.name
    const_get(:NAME)
  end
end

class Fukuzawa < Human
  NAME = "Yukichi"
end

puts Fukuzawa.name

# まず Fukuzawa.nameでFukuzawaクラスのnameメソッドを呼び出そうとする。
# ただし、Fukuzawaクラスにはnameメソッドが定義されてないので、メソッド探索を行い、親クラスのHumanクラスのnameメソッドを呼び出す。
# このときselfを呼び出している。今回Fukuzawaから呼び出しているので、selfはFukuzawaとなる。
# const_getはselfで定義した定数を呼び出す。
# selfはFukuzawaなのでFukuzawaクラスのNAME定数を呼び出す。
# なので正解はYukichi
# またputs Human.nameだとUnkown


class People
  NAME = '人々'

  def self.name
    p self
    const_get(:NAME)
  end
end

class Human < People
  NAME = "Unknown"

  # def self.name
  #   p self
  #   const_get(:NAME)
  # end
end

class Fukuzawa < Human
  NAME = "Yukichi"
end

puts Fukuzawa.name
# Yukichi
puts Human.name
# Unknown
puts People.name
# 人々


'10問目  true X'

class C
public
  def initialize
  end
end

p C.new.private_methods.include? :initialize

# initializeはprivateなどでアクセス修飾子をつけたとしても、privateから変わることはありません。


'11問目  true X'

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
#NameError (uninitialized constant M::CONST)

#C.ancestors => [C, M, E, D, Object, Kernel, BasicObject] となる。
# c.refer_constでrefer_constの探索をする。探索的にすぐmodule Mに定義されているrefer_constを探し当てる。
#ただしCONSTが定義されていない。なのでNameErrorが発生する。


'12問目 OK'
a = (1..5).partition(&:odd?)
p a
# [[1, 3, 5], [2, 4]]


'13問目 OK'

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
  def method_missing(id, *args)
    puts "B#method_missing"
  end
end

obj = B.new
obj.dummy_method
# B#method_missing

'14問目 OK'

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
#"Hello, world"

'15問目 X'

class String
  XXXX
end

p "12345".hoge

# 実行結果
#54321
#alias_method :reverse, :hoge

'16問目 X'


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

# 42


'17問目 X 不明'
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
      p Module.nesting
      CONST
    end
  end
end

p C.new.greet
# ::Cはトップレベルを指すからclass C < Base endを参照する。
# なので親クラスのBaseを参照するから "Hello, world"が正解
# ただ、なんでトップレベルがclass C < Base end部分なのかと
# module pのCONSTが呼ばれないのか今一不明


'18問目 X'

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

'19問目 OK'

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

#'module_evalにブロックを渡した場合のネストは次の通りです。'

#A.module_eval do
#  p Module.nesting # []と表示され、ネストされた状態になく、トップレベルにいることがわかる
#end
#トップレベルで定数を定義した場合はObjectの定数になります。

#B = "Hello, world"
#p Object.const_get(:B) # "Hello, world"と表示される
#問題にあるメソッドA.fはトップレベルにある定数を探索するため答えは15になります。


'20問目 X 正解は1,4'

val = 100

def method(val)
  yield(15 + val)
end

_proc = Proc.new{|arg| val + arg }

p method(val, __(1)__)

#1 &_proc.to_proc

#2_proc.to_proc


#3 _proc

#4 &_proc

'21問目 x 1,3が正解'

'次のプログラムを実行すると、"apple"が一文字ずつ表示されます。
each_charを置き換えても同じ結果になるメソッドを選択肢からすべて選んでください'

enum = "apple".each_char

p enum.next
p enum.next
p enum.next
p enum.next
p enum.next

# to_enum(:each_char)
'上記はstringが対応できる'

# to_enum
'上記は配列に対応できる'

# enum_for(:each_char)
'上記はstringが対応できる'

# enum_for
'上記は配列に対応できる'


'22問目 x 答え20'

'次のプログラムを実行するとどうなりますか'

class C
  p @@val = 10
end

module B
  p @@val = 30
end

module M
  include B
  p @@val = 20

  class << C
    p @@val
  end
end

# 10が表示される

# 20が表示される

# 30が表示される

# 例外が発生する

'クラス変数はクラスに所属するあらゆるもので情報を共有する為にあり、
特異クラス定義の中でクラス変数を定義してもレキシカルに決定されます。'

'次のプログラムではクラス変数は共有されます。'

class C
  class << self
    @@val = 10
  end
end

p C.class_variable_get(:@@val) # 10が表示される
'この問題ではクラスCの特異クラス定義をモジュールMで行っています。
クラス変数はレキシカルに決定されますので答えは20です。'

'23 問目 OK 答え1'

# 次のプログラムと同じ結果になるプログラムを選んでください。

m = Module.new

m.instance_eval do
  m.instance_variable_set :@block, Module.nesting
end

m.instance_eval(<<-EVAL)
  m.instance_variable_set :@eval,  Module.nesting
EVAL

block = m.instance_variable_get :@block
_eval =  m.instance_variable_get :@eval

puts block.size
puts _eval.size

# 0
# 1

# 1
# 1

# 1
# 0

# 0
# 0


# 解説
Module.nesting # はネストの状態を返します。ネストされた場合ではれば配列で表示します。

module B
  module M
    p Module.nesting # [B::M, B] と表示されます
  end
end
ブロックであればネストは定義された場所のネストになり、文字列であればレシーバのコンテキストで評価されます。

_proc = Proc.new {
  p Module.nesting
}

_proc.call # [] が表示されます

m = Module.new

m.instance_eval(<<-EVAL)
  p Module.nesting
  # [#<Class:#<Module:0x007fe71194e210>>] と表示されます
EVAL

m.instance_eval {
  p Module.nesting # [] と表示されます
}
# この問題の答えは次のとおりです。

# 0
# 1

'24問目 OK 1'

begin
  print "liberty" + :fish.to_s # string + stringなのでエラーは出ない。
rescue TypeError
  print "TypeError."
rescue
  print "Error."
else
  print "Else."  # errorがでないのでelseが呼ばられる。
ensure
  print "Ensure." # ensureは必ずよばれる
end

# libertyfishElse.Ensure.
# と表示される

# libertyfish
# Else.
# Ensure.
# と表示される

# libertyfishEnsure.
# と表示される

# Ensure.
# と表示される

'例えば以下だったら、エラーになるのでTypeError.Ensure.となる'
begin
  print "liberty" + :fish
rescue TypeError
  print "TypeError."
rescue
  print "Error."
else
  print "Else."
ensure
  print "Ensure."
end

'25問目 ok 2'

begin
  print "liberty" + :fish
rescue TypeError
  print "TypeError."
rescue
  print "Error."
else
  print "Else."
end

# Error.
# と表示される

# TypeError.
# と表示される

# Else.
# と表示される

# libertyfish
# と表示される

'26問目 x 2'
# 次のプログラムを実行するとどうなりますか
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

#解説

'定数のスコープはレキシカルに決定されます。
ブロックはネストの状態を変更しないので、module_evalのブロックで定義した定数はこの問題ではトップレベルで定義したことになります。
定数EVAL_CONSTはトップレベルで定義していることになりますので、Objectクラスに定数あることが確認することが出来ます。'

'また、Moduleクラスのインスタンスには直接、定数は定義されていませんが継承関係を探索して参照することが出来ます。
const_defined?メソッドは第2引数に継承関係を探索するか指定出来るため、この問題では探索を行うかによって結果が変わります。'

mod = Module.new

mod.module_eval do
  EVAL_CONST = 100
end

puts Object.const_defined? :EVAL_CONST # trueと表示される
puts mod.const_defined? :EVAL_CONST # trueと表示される

# 第2引数にfalseを指定すると継承関係まで探索しない
puts mod.const_defined? :EVAL_CONST, false # falseと表示される
# この問題では指定してない（デフォルト値true）ため探索を行い、定数をどちらも見つけることが出来ます。

'27問目 x 3'

# 期待した出力結果になるようにXXXXに適切なコードを選べ

class String
  # XXXX
end

p "12345".hoge

# 実行結果
# 54321

# alias :hoge, :reverse
# SyntaxError ((irb):55: syntax error, unexpected ',')

# alias :reverse, :hoge
# SyntaxError ((irb):55: syntax error, unexpected ',')

# alias hoge reverse

# alias reverse hoge
# NameError (undefined method `hoge' for class `String')

'解説'

# alias式はメソッドやグローバル変数に別名を付けることができます。
# 定義は以下のようにします。

alias new_method old_method
alias :new_method :old_method
alias $new_global_val $old_global_val
# メソッド内でメソッドに別名をつける必要がある場合は、Module#alias_methodを使います。

alias_method "new_method", "old_method"
alias_method :new_method, :old_method

'28問目 3'

v1 = 1 / 2 == 0
v2 = !!v1 or raise RuntimeError
puts v2 and false

# シンタックスエラーとなる

# 実行時にエラーとなる

# true と表示される

# false と表示される

#解説

'1行目では、Fixnumクラス同士の除算はFixnumクラスになります。
よって、0 == 0が評価され、v1はtrueになります。'

'2行目では、orは左辺が真であればその結果を返します。この時、右辺は評価されません。
左辺が偽であれば、右辺を評価しその結果を返します。
また、orは評価する優先順位が低い演算子です。
よって、優先順位が低いのでv2には!!v1の結果のtrueが入ります。
次に、!!v1 or raise RuntimeErrorが評価され、左辺が真であるため、左辺のみ評価されます。'

'3行目では、andは左辺が真であれば、右辺の結果を返します。左辺が偽であれば、左辺の結果を返します。
また、andは評価する優先順位が低い演算子です。
よって、優先順位がputsメソッドより低いのでputs v2が評価されます。'
'参考: https://qiita.com/riku-shiru/items/533a01bdf18e2e3eef46'

'演算子の優先順位を適切にするためには、括弧で式を区切ります。'


'29問目 x 正解1,4'

# 次のプログラムを実行するために__(1)__に適切なメソッドをすべて選んでください。

class IPAddr
  include Enumerable

  def initialize(ip_addr)
    @ip_addr = ip_addr
  end

  def each
    return enum_for unless block_given?

    @ip_addr.split('.').each do |octet|
      yield octet
    end
  end
end

addr = IPAddr.new("192.10.20.30")
enum = addr.each

p enum.next # 192と表示される
p enum.next # 10と表示される
p enum.next # 20と表示される
p enum.next # 30と表示される

# to_enum

# enum_with

# enum

# enum_for

# 解説

'Enumerableをインクルードした場合は、eachメソッドを実装する必要があります。
ブロックが渡されない場合でも、Enumeratorオブジェクトを返すようにして外部イテレータとしても使えるようにします。'

'Enumeratorオブジェクトを作成するメソッドはenum_for、またはto_enumです'

'30問目 x 4'

10.times{|d| print d < 2...d > 5 ? "O" : "X" }

# シンタックスエラーとなる

# XXXXXXXXXX と表示される

# OOXXXXOOOO と表示される

# OOOOOOOXXX と表示される

#解説

'Integer#timesは0からself -1までの数値を順番にブロックに渡すメソッドです。'

'd < 2...d > 5の部分は条件式に範囲式を記述しています。
この式は、フリップフロップ回路のように一時的に真偽を保持するような挙動をとります。'

'詳細は、Rubyリファレンスに詳しい説明がありますのでそちらを参照してください。'

'31問目 x ' # なぜか0と答えたのに不一致。けどコード調べても確実に0になる。

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

#解説
'数値はFixnumクラスのオブジェクトです。FixnumクラスはIntegerクラスのサブクラスです。'

'問題では、Integerクラスへ+メソッドをオープンクラスし、オーバーロードているように取れます。
しかし、+メソッドはFixnumクラスで定義されています。
よって、元のFixnum#+が呼ばれます。'

p 1.class.ancestors           #=> [Fixnum, Integer, Numeric, Comparable, Object, Kernel, BasicObject] ここもFixnumはない
p Numeric.method_defined?(:+) #=> false
p Integer.method_defined?(:+) #=> false ここもなぜか trueになる
p Fixnum.method_defined?(:+)  #=> true

'32問目 OK 3'

module M1
end

module M2
end

class C
  prepend M1, M2
end

p C.ancestors

# [C, M1, M2, Object, Kernel, BasicObject]と表示される

# [C, M2, M1, Object, Kernel, BasicObject]と表示される

# [M1, M2, C, Object, Kernel, BasicObject]と表示される

# [M2, M1, C, Object, Kernel, BasicObject]と表示される


'33問目 x 3'

class Company
  attr_reader :id
  attr_accessor :name
  def initialize id, name
    @id = id
    @name = name
  end
  def to_s
    "#{id}:#{name}"
  end
  def <=> other
    other.id <=> self.id
  end
end

companies = []
companies << Company.new(2, 'Liberyfish')
companies << Company.new(3, 'Freefish')
companies << Company.new(1, 'Freedomfish')

companies.sort! # def <=> other endがないとsortするとArgumentErrorになる

companies.each do |e|
  puts e
end

# 1:Freedomfish
# 2:Liberyfish
# 3:Freefish
# と表示される

# 3:Freefish
# 1:Freedomfish
# 2:Liberyfish
# と表示される

# 3:Freefish
# 2:Liberyfish
# 1:Freedomfish
# と表示される

# 1:Freedomfish
# 3:Freefish
# 2:Liberyfish
# と表示される

'解説

Array#sortは比較に<=>を使用しています。
自作クラスの場合はオブジェクトIDが比較対象となります。
別のソート条件を用いるには<=>をオーバーライドします。

Fixnum#<=>(other)は以下の結果を返します。

selfがotherより大きい場合は、1を返します。
selfがotherと等しい場合は、0を返します。
selfがotherより小さい場合は、-1を返します。
問題のコードでは、sort!は破壊的メソッドです。
よってputs時点ではソートが行われて表示されます。'

#今いち引数otherに何が入るのかわからん。

'34問目 x  1'

val = 1i * 1i
puts val.class

# Complexと表示される

# Fixnumと表示される

# NilClassと表示される

# エラーになる

`1iは複素数(Complex)のオブジェクトを表します。
Complex同士の演算はComplexを返します。`

'35問目 x 4'
array = ["a", "b", "c"].freeze
array = array.map!{|content| content.succ}

p array

# ["a", "b", "c"]と表示される

# ["A", "B", "C"]と表示される

# ["b", "c", "d"]と表示される

# 例外が発生する

'freezeはオブジェクトの破壊的な変更を禁止します。
問題では配列の破壊的な変更を禁止しますので、次のプログラムでは例外が発生します。'

array = ["a", "b", "c"].freeze
array << "d" # 例外発生

p array
'map!はレシーバーの配列を更新します。次のプログラムでは、map!で内容を変更した後でもオブジェクトIDは同じです。'

array = ["a", "b", "c"]
mapper = array.map!{|content| content.succ}

p array.__id__ #=> 70361769061320
p mapper.__id__ #=> 70361769061320
'freezeはオブジェクトの破壊的な変更を禁止していますので、map!を実行すると例外が発生します'
