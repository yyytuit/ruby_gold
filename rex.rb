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

module M
  CONST = "Hello, world"

  class C
    def awesome_method
      CONST
    end
  end
end

p M::C.new.awesome_method
# => "Hello, world"


'選択肢1は不正解'

module M
  CONST = "Hello, world"
  # p Module.nesting [M]
end

class M::C
  def awesome_method
    CONST
  end
  # p Module.nesting [M::C]
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
# class_evalをにブロックを渡すことで、Cクラスにawesome_methodメソッドを定義したかのように見せることができる。
# なのでmodule M内でCクラスにawesome_methodを定義し、 modudleMで定義したCONSTを呼び出している。
C.method_defined?(:awesome_method)
# => true


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
C.method_defined?(:awesome_method)
# => true

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
    # CONST = "010"

    module M2
      # CONST = "011"

      class Ca
        CONST = "100"
      end

      class Cb < Ca
        p CONST
      end
    end
  end
end

# 解説

# Rubyは定数の参照はレキシカルに決定されます。名前空間ではなく、プログラム上の定義された場所と使われている場所の静的な位置づけが重要です。
# 例えば、次のプログラムでは期待した結果が得られません。CONSTがモジュールMのスコープにあるためです。

module M
  CONST = "Hello, world"
end

class M::C
  def awesome_method
    CONST
  end
end

p M::C.new.awesome_method # 例外が発生する

# 一方で同じレキシカルスコープにある場合は例外は発生しません
module M
  CONST = "Hello, world"

  class C
    def awesome_method
      CONST
    end
  end
end

p M::C.new.awesome_method
#また、使われている定数の場所がネストされている場合は内側から順に定数の探索が始まります。
#なのでレキシカルスコープの探索から恥じまる。
#例

#以下はレキシカルスコープ内M1::C2::M2::Cbの中にM1::C2のCONST = "010"を発見し出力する
module M1
  class C1
    CONST = "001"
  end

  class C2 < C1
    CONST = "010"

    module M2
      # CONST = "011"

      class Ca
        CONST = "100"
      end

      class Cb < Ca
        p CONST
      end
    end
  end
end

>"010"

#レキシカルスコープに定数がない場合は、スーパークラスの探索を行います。

# 例
# 以下はレキシカルスコープ内M1::C2::M2::Cbの中にCONSTが定義されていないので、スーパークラスをたどる
# なので出力はCONST = "100"
module M1
  class C1
    CONST = "001"
  end

  class C2 < C1
    # CONST = "010"

    module M2
      # CONST = "011"

      class Ca
        CONST = "100"
      end

      class Cb < Ca
        p CONST
      end
    end
  end
end

>"100"

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

# 解説
# レキシカルスコープには定数はありません。その場合はスーパークラスを探索します。
# 特異クラスの継承関係にクラスCがありますので定数を見つけることができます。

# 参考：特異クラスの継承関係

# [#<Class:#<C:0x007fa4741607e0>>, C, Object, Kernel, BasicObject]

'15問目 X'

class String
  XXXX
end

p "12345".hoge

# 実行結果
#54321
#alias_method :reverse, :hoge

# 解説
# alias_methodは既に存在するメソッドの別名を付けます。
# 宣言はalias 新メソッド名 旧メソッド名形式で行います。

# よく似たメソッドにaliasがあります。異なる点は下記です。

# aliasのメソッド名は識別子かSymbolを受け取ります。
# alias_methodのメソッド名はStringかSymbolを受け取ります。


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

# 解説
# module_evalに文字列を引数とした場合は、レシーバーのスコープで評価されます。
# 問題のプログラムを次のようにするとネストの状態を調べることができます。

A.module_eval(<<-CODE)
  p Module.nesting # [A]と表示され、モジュールAのスコープにあることがわかる
CODE
# 定数は静的に探索が行われますので、A::Bの42が答えになります。


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


'18問目 X 1'

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

A.module_eval do
 p Module.nesting # []と表示され、ネストされた状態になく、トップレベルにいることがわかる
end
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

# ということはクラス変数じゃなかったら?

class C
  @val = 10
end

module B
  @val = 30
end

module M
  include B
  @val = 20

  class << C
    p @val
  end
end
# nil

class C
  Val = 10
end

module B
  Val = 30
end

module M
  include B
  Val = 20

  class << C
    p Val
  end
end
# 20

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

# ちなみに
prepend M1
prepend M2
# とすると
# [M2, M1, C, Object, Kernel, BasicObject]

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


'36問目 ok 1'

while not DATA.eof?
  print DATA.read 1
end

__END__
1
2
3
4


# 1
# 2
# 3
# 4
# と表示される

# エラーが発生する

# 何も表示されない

# 4
# 3
# 2
# 1
# と表示される

'37問目 ok 3'

val = 0

class B
end

class C < B
end

if C < BasicObject
  val += 100
else
  val += 15
end

if B < C
  val += 100
else
  val += 15
end

p val

# 100と表示される

# 200と表示される

# 115と表示される

# 130と表示される

'38問目 x 3'

begin
  raise "Err!"
rescue => e
  puts e.class
end

# エラーが発生する

# StandardErrorと表示される

# RuntimeErrorと表示される

# Exceptionと表示される

# 解説

'raiseの例外クラスを省略した場合は、RuntimeErrorを発生させます。
rescueの例外クラスを省略した場合は、StandardErrorを捕捉します。
RuntimeErrorはstanderdErrorのサブクラスです。'



'39問目 x 3'

module K
  CONST = "Good, night"
  class P
  end
end

module K::P::M
  class C
    CONST = "Good, evening"
  end
end

module M
  class C
    CONST = "Hello, world"
  end
end

class K::P
  class M::C
    p CONST
  end
end


# 例外が発生する

# "Good, night"と表示される

# "Good, evening"と表示される

# "Hello, world"と表示される

# 解説

'クラスK::PにあるクラスM::Cはトップレベルにあるものとは異なります。
ネスト状態が同じものがあれば、そのレキシカルスコープから定数の探索を行います。
この問題では定数CONSTが参照しているのはK::P::M::Cで、そのレキシカルスコープにある定数を探索しますので"Good, evening"と表示されます。
'

module K
  class P
    p Module.nesting # [K::P, K]と表示されます
  end
end

module K::P::M
  class C
    p Module.nesting # [K::P::M::C, K::P::M]と表示されます
  end
end

module M
  class C
    p Module.nesting # [M::C, M]と表示されます
  end
end

class K::P
  class M::C
    p Module.nesting # [K::P::M::C, K::P]と表示されます
  end
end


'40問目 x 4'

'singleton_classは特異クラスを取得するメソッドです。
特異クラスは#<Class:クラス名>のように表示されます。'

class C
end

p C.singleton_class # #<Class:C>と表示される


'次のプログラムを実行するとどうなりますか'

class C
end

p C.singleton_class.singleton_class.singleton_class.singleton_class

# <Class:C>と表示される

# <Class:#<Class:C>>と表示される

# <Class:#<Class:#<Class:C>>>と表示される

# <Class:#<Class:#<Class:#<Class:C>>>>と表示される


'singleton_classはKernelモジュールにあるインスタンスメソッドです。'

m = C.method :singleton_class
p m.owner # Kernel
'owner このメソッドが定義されている class か module を返します。'
'特異クラスの継承関係にKernelモジュールがあるため、singleton_classを呼び出すことが出来るため、特異クラスの特異クラスを取得するようなことができます。'

class C
end

p C.singleton_class # #<Class:C>
p C.singleton_class.singleton_class # #<Class:#<Class:C>>
p C.singleton_class.singleton_class.singleton_class # #<Class:#<Class:#<Class:C>>>
p C.singleton_class.singleton_class.singleton_class.singleton_class # #<Class:#<Class:#<Class:#<Class:C>>>>
# この問題ではsingleton_classを4回呼び出していますので#<Class:#<Class:#<Class:#<Class:C>>>>が答えになります。


'41問目 ok 2'

class C
  CONST = "Good, night"
end

module M
  CONST = "Good, evening"
end

module M
  class C
    CONST = "Hello, world"
  end
end

module M
  class ::C
    p CONST
  end
end

# 例外が発生する

# "Good, night"と表示される

# "Good, evening"と表示される

# "Hello, world"と表示される

'この問題ではクラスCにある定数CONSTを参照していますが、トップレベルにあるものと同じです。

クラス名が修飾されている場合は同じ名前であっても別のクラスになりますが、
::演算子を使うことによりネストを指定することができます。

モジュールMにあるクラスCでメソッドの呼び出しを行うにはM::Cと書きます。
また、先頭に::をつけるとトップレベルから探索を行います。

次のプログラムでは先頭に::がある場合はモジュール内にあってもトップレベルのクラスCと同じです。
M::Cの場合はトップレベルのクラスCとは別のものです。'

class C
  p Module.nesting # [C]と表示されます
end

module M
  class ::C
    p Module.nesting # [C, M]と表示されます
  end
end

module M
  class C
    p Module.nesting # [M::C, M]と表示されます
  end
end
'この問題では先頭に::がついていますのでトップレベルにあるクラスCと同じです。
よって、"Good, night"と表示されます。'

'42問目 ok 4'

val = 100

def method(val)
  yield(15 + val)
end

_proc = Proc.new{|arg| val + arg }

p method(val, &_proc)


# 130と表示される

# 200と表示される

# 115と表示される

# 215と表示される


'43問目 ok 1'

fiber = Fiber.new do
  __(1)__ 'Hi, there!'
end

p __(2)__
期待値

"Hi, there!"

# __(1)__ ruby Fiber.yield
# __(2)__ ruby fiber.resume

# __(1)__ ruby Fiber.resume
# __(2)__ ruby fiber.yield

# __(1)__ ruby fiber.resume
# __(2)__ ruby Fiber.yield

# __(1)__ ruby fiber.yield
# __(2)__ ruby Fiber.resume

# 解説

'Fiberは軽量スレッドを提供します。

Fiber#resumeを実行するとFiber.yieldが最後に実行された行から再開するか、Fiber.newに指定したブロックの最初の評価を行います。

サンプルプログラムを実行して、処理の内容を見てみましょう。'

f = Fiber.new do |name|
  Fiber.yield "Hi, #{name}"
end

p f.resume('Matz') # 'Hi, Matz'と表示されます。
f.resume('Matz')を実行する。
'Fiber.newのブロックを評価し、引数nameには'Matz'をセットする。
変数を展開して、'Hi, Matz'をFiber.yieldの引数にセットする。
Fiber.yield('Hi, Matz')を実行すると、f.resume('Matz')の戻り値が'Hi, Matz'になる。
Fiber.yield('Hi, Matz')の実行終了を待たずに、プログラムが終了する。
問題のプログラムの期待値を得る組み合わせは次のとおりです。'

fiber = Fiber.new do
  Fiber.yield 'Hi, there!'
end

p fiber.resume
'Hi, there!'


'44問目 x 2,3,4'

# 次のプログラムと同じ結果になる選択肢を選んでください。
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


'45問目 x 3'
array = ["a", "b", "c"].freeze

array.each do |chr|
  chr.upcase!
end

p array

# 例外が発生する

# ["a", "b", "c"]と表示される

# ["A", "B", "C"]と表示される

# ["d", "e", "f"]と表示される

# 解説

'freezeはオブジェクトの破壊的な変更を禁止します。
次のプログラムでは配列の破壊的な変更を禁止しますので、例外が発生します。'

array = ["a", "b", "c"].freeze
array << "d" # 例外発生

p array
'配列の破壊的な変更を禁止しますが、配列の要素の破壊的な変更は禁止していません。
したがって、upcase!を実行しても例外は発生しません。

["A", "B", "C"]がこの問題の答えです。'

'46問目'

class Human
  attr_reader :name

  alias original_name name

  def name
    "Mr. " + original_name
  end

  def initialize(name)
    @name = name
  end
end
human = Human.new("Andrew")
puts human.name

# 選択肢
class Human
  attr_reader :name

  alias_method :original_name, :name

  def name
    "Mr. " + original_name
  end

  def initialize(name)
    @name = name
  end
end
human = Human.new("Andrew")
puts human.name

# 選択肢
class Human
  attr_reader :name

  def name
    "Mr. " + super
  end

  def initialize(name)
    @name = name
  end
end
human = Human.new("Andrew")
puts human.name


# 選択肢
class Human
  attr_reader :name

  def name
    "Mr. " + @name
  end

  def initialize(name)
    @name = name
  end
end
human = Human.new("Andrew")
puts human.name

# 選択肢
class Human
  attr_reader :name

  def name
    "Mr. " + name
  end

  def initialize(name)
    @name = name
  end
end

human = Human.new("Andrew")
puts human.name


# 解説

'この問題ではアクセサをattr_readerで作成していますが、aliasでoriginal_nameとして別名をつけています。

新しく定義したnameメソッドを実行すると、Mr. Andrewと表示されます。

aliasと同じくメソッドの別名をつけます。オーバーライドして元のアクセサを呼び出すことができますので、問題と同じ結果になります。'

class Human
  attr_reader :name

  alias_method :original_name, :name

  def name
    "Mr. " + original_name
  end

  def initialize(name)
    @name = name
  end
end
human = Human.new("Andrew")
puts human.name

# nameメソッドの中でsuperで親クラスの同名のメソッドを呼び出そうとしていますが、親クラスのObjectにはそのようなメソッドはありませんので同じ結果になりません。
class Human
  attr_reader :name

  def name
    "Mr. " + super
  end

  def initialize(name)
    @name = name
  end
end
human = Human.new("Andrew")
puts human.name

# イニシャライザで初期化したインスタンス変数をnameメソッドで参照していますので、問題と同じ結果になります。
class Human
  attr_reader :name

  def name
    "Mr. " + @name
  end

  def initialize(name)
    @name = name
  end
end
human = Human.new("Andrew")
puts human.name

# nameメソッドの中で同名のメソッドを呼び出していますので、再帰呼出しになっています。終了せず、例外が発生しますので問題と同じ結果にはなりません。
class Human
  attr_reader :name

  def name
    "Mr. " + name
  end

  def initialize(name)
    @name = name
  end
end

human = Human.new("Andrew")
puts human.name

'47問目 x 124'

# 問題
# Kernelモジュールで定義されているメソッドを選んでください。

# Kernel#String

# Kernel#Array

# Kernel#Date

# Kernel#Hash

'Kernel#Array、Kernel#Hash、Kernel#StringはKernelのモジュール関数として定義されています。
Kernel#Dateはありません。

これらのメソッドは次のように使います。

p Array("Awesome Array") #=> ["Awesome Array"]
p Hash(awesome_key: :value) #=> {:awesome_key=>:value}
p String('0123456789') #=> "0123456789"'


'48問目 x 4'

p Class.method_defined? :new
p String.method_defined? :new
p Class.singleton_class.method_defined? :new
p String.singleton_class.method_defined? :new

'Stringクラスはクラスメソッドnewでインスタンスを生成します。
StringクラスはClassクラスのインスタンスですので、StringクラスにあるnewはClassクラスのインスタンスメソッドです。
また、ClassクラスはRubyで多種多様なクラスを生成しますので、Classにもクラスメソッドとしてnewがあります。'

str = String.new("Awesome String") # new は Class のインスタンスメソッド
# str.new こういった呼び方は出来ない
Klass = Class.new # new は Class のクラスメソッド

# 選択肢
# true
# true
# true
# false
# 選択肢
# false
# false
# true
# true
# 選択肢
# true
# false
# false
# true
# 選択肢
# true
# false
# true
# true

'49問目 ok '

require 'yaml'

yaml = <<YAML
  sum: 510,
  orders:
    - 260
    - 250
YAML

object = YAML.__(1)__

p object

# 期待値（Hashオブジェクト）

{"sum"=>510, "orders"=>[260, 250]}

#答え
load yaml


'50問目'

CONST_LIST_A = ['001', '002', '003']
begin
  CONST_LIST_A.map{|id| id << 'hoge'}
rescue
end

CONST_LIST_B = ['001', '002', '003'].freeze
begin
  CONST_LIST_B.map{|id| id << 'hoge'}
rescue
end

CONST_LIST_C = ['001', '002', '003'].freeze
begin
  CONST_LIST_C.map!{|id| id << 'hoge'}
rescue
end

CONST_LIST_D = ['001', '002', '003'].freeze
begin
  CONST_LIST_D.push('add')
rescue
end

p CONST_LIST_A
p CONST_LIST_B
p CONST_LIST_C
p CONST_LIST_D

'変数は1文字目を大文字にすると定数になります。定数には次の特徴があります。

代入を行うと警告が発生しますが、値は変更されます。
中身を直接変更した場合は値が変わります。ただし、警告は発生しません。
特徴1の例'

CONST = ["001", "002", "003"]
CONST = ["A", "B", "C"]
p CONST

# <実行結果>
# warning: already initialized constant CONST
# ["A", "B", "C"]
# 特徴2の例

CONST = ["001", "002", "003"]
CONST[0] = "A"
p CONST

# <実行結果>
# ["A", "002", "003"]
'freezeはオブジェクトを凍結します。凍結されたオブジェクトは次の特徴があります。

破壊的な操作ができません。
オブジェクトの代入ができます。
自作クラスのインスタンス変数をfreezeしない限り、変更できます。
特徴1の実行結果'

hoge = "hoge".freeze
hoge.upcase!
p hoge

# <実行結果>
# RuntimeError: can't modify frozen String
# 特徴2の実行結果

hoge = "hoge".freeze
hoge = "foo".freeze
p hoge

# <実行結果>
# foo
# 特徴3の実行結果

class Fish
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

liberty = Fish.new("liberty")
liberty.name.upcase!
p liberty

# <実行結果>
# LIBERTY
