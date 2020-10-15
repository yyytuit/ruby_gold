# 期待される出力となるように、(1)に入る選択肢を２つ選んでください

class Greeter
  class << self
    def hello
      puts "Hello there!"
    end
  end
end

__(1)__

[期待される出力]
Hello there!

# A: Greeter.new.hello

# B: Greeter.hello

# C: Greeter.new.class.hello

# D: `Greeter.class.new.hello

#  答え B、C

# 問題8
# 期待される出力結果となるように、(1)に入る選択肢を２つ選んでください

__(1)__

p multiply_by(4) { 2 + 3 }

[Execution Result]
20


A:

def multiply_by(n, &block)
  n * block.call
end
B:

def multiply_by(n, &block)
  n * block
end
C:

def multiply_by(n)
  n * yield
end
D:

def multiply_by(n)
  n * yield.call
end

# 答え：A,C
# 解説
# メソッドシグネチャで明示的に指定されているかどうかにかかわらず、Rubyのすべてのメソッドはブロックを受け入れることができます。
# `yield`キーワードは、ブロックを暗黙的に呼び出すために使用されます。
# `＆block`構文は、ブロックを` Proc`オブジェクトに変換するために使用されます。
# これは、 `call（）`を介して呼び出すか、他のメソッドに渡すことができます。


# 問題9
# 期待される出力結果となるように、次の(1)に入る選択肢を二つ選んでください

__(1)__

p sum { |e| e << 1 << 5 << 7 }

[期待される出力]
13


A:

def sum(&block)
  array = []

  block(array)

  array.reduce(:+)
end
B:

def sum(&block)
  array = []

  block.call(array)

  array.reduce(:+)
end
C:

def sum
  array = []

  yield(array)

  array.reduce(:+)
end
D:

def sum
  array = []

  yield.call(array)

  array.reduce(:+)
end

# 答え：B,C
# yieldを介して引数を使用してブロックを呼び出す場合、関数型の構文が使用されます。
# Procオブジェクトを介してブロックを呼び出すとき、引数はcall（）メソッドに渡されます。


# 期待される出力結果となるように(1)に入る選択肢を二つ選んでください
words = ["apple", "banana", "cabbage"]
pop = __(1)__{ words.pop }
3.times{ puts pop.call }

[期待される出力]
cabbage
banana
apple

# A: Proc.new

# B: Block.new

# C: lambda

# D: `Lambda.new

# 答え：A,C
# 解説
# `Proc.new`と` lambda`はそれぞれ `Proc`オブジェクトを作成しますが、動作は互いに同一ではありません。
# - 「ラムダ」を介して生成された「Proc」は、受け入れられる引数について厳密です。一方、通常の「Proc」は、余分な未使用の引数を無視します。
# - 「ラムダ」内からの「return」呼び出しはラムダ自体から返されますが、通常の「Proc」オブジェクトからの「return」呼び出しはブロックを呼び出したメソッドから返されます。


# 期待される出力結果になるように、(1)に入る選択肢を一つ選んでください
add = __(1)__
puts add.call("hello")

[期待される出力]
HELLO


# A: ->(e) { e.upcase }

# B: \(e) -> { e.upcase }

# C: -> { (e) e.upcase }

# D: `-> { |e| e.upcase
# 答え：A
# 解説
# ->（...）{}（ラムダリテラル）構文は、 lambda {| ... |と同等の簡略表記です。 }


# 次のコードの実行結果を選択肢から一つ選んでください

original = [[1,2],[3,4]]

copy = original.dup

original[0][0] = 42

p copy

A: [[1,2],[3,4]]
B: [[42,2],[3,4]]
C: [[42],[3,4]]
D: A runtime error occurs.

# 答え：B

# 解説
# Object＃dupとObject＃cloneはどちらも浅いコピーを作成します。
# Arrayの場合、これは配列自体はコピーされますが、配列内のオブジェクトはコピーされないことを意味します。
# したがって、この特定の例では、「original [0]」と「copy [0]」の両方が同じオブジェクトを参照しています。
# Rubyでディープコピーを作成するために使用できる規則の1つは、Marsalコアクラスを使用してオブジェクトをシリアル化してから逆シリアル化することです。
# copy = Marsal.load（Marhal.dump（original））。


# 期待される出力結果となるように、(1)に入る選択肢を一つ選んでください

obj = Object.new

def obj.hello
  puts "Hi!"
end

copy = __(1)__

copy.hello

[期待される出力]
Hi!


# A: Marshal.load(Marshal.dump(obj))

# B: obj.dup

# C: obj.clone

# D: `obj.copy

# 答え：C

# 解説
# Object＃dupはオブジェクトのシングルトンメソッドをコピーしません。
# 「Marshal.dump」は、シングルトンメソッドが定義されているオブジェクトをシリアル化できません。
# Object＃copyメソッドはありません。


class ShoppingList
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def __(1)__
    @items.map { |e| "- #{e} " }.join("\n")
  end
end

list = ShoppingList.new

list.add_item("Milk")
list.add_item("Bread")
list.add_item("Eggs")

puts list

[期待される出力]
- Milk
- Bread
- Eggs

# A: to_s

# B: to_str

# C: inspect

# D: `puts

# 答え：A
# 解説
# 多くのRubyメソッド（ Kernel＃putsを含む）は、オブジェクトを文字列表現に変換するためにto_sを呼び出します。
# Object＃to_sのデフォルトの実装は、次のような単純で一般的な出力を生成します。

# ＃<ShoppingList：0x007fb651918610>

# to_sメソッドが他のオブジェクトでオーバーライドされている場合、この設問に示すように、オブジェクトのより良い文字列表現を提供するために使用できます。


class ShoppingList
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def __(1)__
    "ShoppingList (##{object_id})\n  @items: #{@items.inspect}"
  end
end

list = ShoppingList.new

list.add_item("Milk")
list.add_item("Bread")
list.add_item("Eggs")

p list

# [期待される出力結果]
ShoppingList (#70338683731980)
  @items: ["Milk", "Bread", "Eggs"]

#   A: to_s

# B: to_str

# C: inspect

# D: `p

# ernel＃pメソッドは、デバッグ目的で使用できる文字列を生成するために、引数でinspectを呼び出します。
# Object＃inspectリストのデフォルトの機能は基本的な有用な情報を提供しますが、出力は特定のクラスまたはオブジェクトのメソッドをオーバーライドすることでカスタマイズできます。

# 次の中から、正しいものを選択肢の中から一つ選んでください

A: Kernel#putsは、引数でto_strを呼び出して文字列表現を生成します。

B: Kernel#p は、引数でto_strを呼び出して文字列表現を生成します。

C: to_strのデフォルト実装は、RubyのObjectクラスによって提供されます

D: to_strメソッドは、Stringインスタンスと同様に動作できるオブジェクトによってのみ実装されます。

# 答え：D

# 解説
# to_strメソッドは、RubyのStringコンセプトに密接に対応するオブジェクトがあり、 String自体ではない場合にのみ役立つため、実際にはほとんど実装されません。
# したがって、このメソッドは特定の低レベルのデータ構造によって実装される可能性がありますが、「to_s」および「inspect」の使用目的と同様の目的で使用することを意図したものではありません。

# 次のコードの実行結果を選択肢から一つ選んでください

a, b, c = ["apple", "banana", "carrot", "daikon"]

p c


# A: ["apple", "banana", "carrot", "daikon"]

# B: "carrot"

# C: ["carrot"]

# D: `["carrot", "daikon"]

# 答え：B

# 次のコードの実行結果を選択肢から一つ選んでください

a, b, *c = ["apple", "banana", "carrot", "daikon"]

p c

# A: ["apple", "banana", "carrot", "daikon"]

# B: "carrot"

# C: ["carrot"]

# D: `["carrot", "daikon"]

# 答え：D

# 解説
# スプラット演算子（ *）を使用して、残りの右辺値をすべて配列に配置し、それらを単一の変数に割り当てることができます。

# 期待される出力結果になるコードを選択肢の中から、一つ選んでください

# [期待される出力]
[["apple", "banana", "carrot"]]

A:

def fx(*args)
  p(args)
end
fx(*["apple", "banana", "carrot"])
B:

def fx(*args)
  p(args)
end
fx(["apple", "banana", "carrot"])
C:

def fx(*args)
  p(args)
end
fx("apple", "banana", "carrot")
D:

def fx(*args)
  p(*args)
end
fx(["apple", "banana", "carrot"])

# 答え：B

# 解説
# splat演算子（ *）をメソッドパラメーターと共に使用すると、残りのすべての引数が配列にラップされ、この1つのパラメーターによって参照されるようになります。
# 上記の回答（B）では、 fx（* args）メソッドは0個以上の引数を受け入れ、それらすべてを args配列内に配置します。
# したがって、 fx（[ apple 、 banana 、 carrot ]）が呼び出されると、単一の引数（配列）が別の配列内に配置されるため、 argsは[[appleを参照します。 「banana」、「calot」]]

# 期待される出力結果となるように、(1)に入る選択肢を二つ選んでください

def add(x,y)
  x + y
end

__(1)__

[期待される出力]
5


# A: p add(3,2)

# B: p add(*[3,2])

# C: p add([3,2])

# D: `p add(**[[3,2]])

# 答え：A,B

# 解説
# スプラット演算子（ *）がメソッド呼び出しの配列で呼び出されると、配列は展開され、メソッドに渡される引数リストとして扱われます。

# 次の実行結果となるように、(1)に入る選択肢を３つ選んでください

def add(x:, y:, **params)
  z = x + y

  params[:round] ? z.round : z
end

__(1)__

[Execution Result]
7


# A: p add(x: 2.75, y: 5.25, round: true)

# B: p add(x: 3.75, y: 3, round: true)

# C: options = {:round => true}; p add(x: 3.75, y: 3, **options)

# D: p add(x: 3, y: 4)

# E: `p add(x: 7)

# 答え：B,C,D
# 解説
# キーワードパラメータを使用するメソッドを使用する場合、「**」演算子を使用して、明示的に指定されていないキーワードをオプションの「ハッシュ」にキャプチャできます。

# **演算子は、ハッシュをキーワード引数リストに変換するメソッドを呼び出すときにも使用できます。

# 期待される実行結果となるように、(1)に入る選択肢を二つ選んでください

class Speaker
  @message = "Hello!"

  class << self
    @message = "Howdy!"

    def speak
      @message
    end
  end
end

__(1)__

[期待される実行結果]
Hello!


A: puts Speaker.speak

B: puts Speaker.singleton_class.speak

C: puts Speaker.instance_variable_get(:@message)

D: puts Speaker.singleton_class.instance_variable_get(:@message)

# 答え：A,C

# 解説
# クラスはRubyのオブジェクトであるため、クラスインスタンス変数を定義できます。

# また、Rubyのすべてのオブジェクトには、クラスオブジェクトを含むシングルトンクラスが関連付けられています。

# この例では、「Speaker」クラスと「Speaker」のシングルトンクラスに「@message」という名前のインスタンス変数があります。 シングルトンメソッド「Speaker.speak」は「Speaker」クラスのコンテキストで評価されるため、「@ message」は「Speaker」クラス定義内で定義されたインスタンス変数を参照し、シングルトンクラス内で定義されたインスタンス変数は参照しません。

# 次のコードの実行結果を選択肢から一つ選択してください

class Speaker
  @message = "Hello!"

  class << self
    @message = "Howdy!"
  end
end

class << Speaker
  p @message
end


# A: "Hello!"

# B: "Howdy!"

# C: nil

# D: A syntax error is raised

# 期待される出力結果となるように、(1)に入る選択肢を一つ選んでください

def x
  puts "x"
end

def y
  puts "y"
  throw :done
end

def z
  puts "z"
end


__(1)__ do
  x
  y
  z
end

puts "done!"

[Execution Result]
x
y
done!


# A: try

# B: catch

# C: catch :done

# D: `rescue

# 答え：C

# 解説
# 「catch」ブロック内では、「throw」ステートメントが実行されるまで、コードは通常どおり実行されます。
# 次に、「throw」を介して渡されたシンボルが「catch」シンボルと一致する場合、Rubyはブロックを終了し、それに続くものはすべて実行し続けます。

# 「catch」ブロックが「throw」と一致しない場合、Rubyは、スローされたシンボルに一致するか、
# キャッチされないトップレベルに到達するブロックを見つけるまで、ネストされた「catch」ブロックを裏返しに続けます。 例外が発生します。

期待される出力結果となるように、(1)に入る選択肢を一つ選んでください

letters = catch(:done) do
  ("a".."z").each do |a|
    ("a".."z").each do |b|
      ("a".."z").each do |c|
        if a < b && b < c
          __(1)__
        end
      end
    end
  end
end

puts letters.join

[期待される出力結果]
abc


# A: throw [a,b,c]

# B: throw [a,b,c], :done

# C: throw :done, [a,b,c]

# D: `raise :done, [a,b,c]

# 答え：C

# 解説
# 2つの引数形式の「throw」が使用される場合、2番目の引数は対応する「catch」呼び出しから返されます。

# 期待される出力結果となるように、(1)に入る選択肢を二つ選んでください
begin
  raise __(1)__
rescue
  puts "OK"
end

[Execution Result]
OK


# A: raise StandardError

# B: raise Exception

# C: raise ArgumentError

# D: `raise ScriptError

# 答え：A,C
# 解説
# この質問にリストされている各クラスのチェーンは次のようになっています。

# ArgumentError < StandardError < Exception

# ScriptError < Exception

# 特定のエラークラスなしで rescueが呼び出されると、デフォルトでStandardErrorとその子孫をキャッチします。
# コアRubyのほとんどの例外は StandardErrorの子孫ですが、Exceptionベースクラスから直接派生する他のクラス階層に存在する、通常は救助を意図していないものもあります。

# 次のコードの実行結果を選択肢の中から選んでください

AnError = Class.new(Exception)

begin
  raise AnError
rescue
  puts "Bare rescue"
rescue StandardError
  puts "StandardError rescue"
rescue Exception
  puts "Exception rescue"
rescue AnError
  puts "AnError rescue"
end


A:

Bare rescue
B:

StandardError rescue
C:

AnError rescue
D:

Exception rescue
E:

Exception rescue
AnError rescue

# 答え：D
# 解説
# rescue Exceptionとrescue AnErrorは両方とも発生した例外に一致しますが、この例では rescue Exception節がキャッチされ、rescue AnErrorは無視されます

# 次のコードの実行結果を選択してください。

CustomError = Class.new(StandardError)

def boom
  raise CustomError
rescue
  raise
end

begin
  boom
rescue => e
  p e.class
end


# A: CustomError

# B: StandardError

# C: Exception

# D: RuntimeError

# E: `SyntaxError

# 答え：A

# 解説
# 例外タイプを指定せずに「rescue」ブロック内で「raise」が呼び出された場合、発生した例外タイプはレスキューされた例外と一致します。

# 「raise」が呼び出され、現在のコンテキストでレスキューされた例外がない場合、デフォルトで「RuntimeError」が発生します。

# 次のコードの実行結果を選択してください

def greeting
  "hello"
ensure
  puts "Ensured called!"

  "hi"
end

puts greeting

A:

hello
B:

hi
C:

Ensure called!
hello
D:

Ensure called!
hi

# 答え：C
# 解説
# メソッドの「ensure」ブランチ（またはbegin/endブロック）は、例外が発生したかどうかに関係なく、常に実行されます。
#  ただし、「ensure」ブランチからの暗黙的な戻り値は存在しないため、代わりに「ensure」ブランチが実行される直前に実行された式の結果に暗黙的な戻り値が設定されます。

# 次のコードの実行結果を選択してください
class Identity
  def self.this_object
    self.class
  end

  def this_object
    self
  end
end

p Identity.this_object.class
p Identity.new.this_object.class


A:

Identity
Identity
B:

Class
Identity
C:

Object
Identity
D:

Class
Object

# 答え：B

# 解説
# クラスメソッドでは、 selfはClassオブジェクトのインスタンスを指します。 インスタンスメソッドでは、「self」は現在インスタンス化されているオブジェクトが何であるかを指します。

# 次のコードの実行結果を選択してください

module Mixin
  def this_object
    self
  end
end

class Identity
  include Mixin
end


p Identity.new.this_object.class


# A: Mixin

# B: Class

# C: Object

# D: `Identity

# 答え：D

# 解説
# モジュールミックスインやクラス継承を含む複雑な祖先チェーンでも、「self」は常に現在のコンテキスト内でのオブジェクトとなります。

# 設問の例では、「this_object」は「Mixin」モジュールによって定義されますが、「Identity」クラスのインスタンスに含まれて呼び出されており、「self」は「Identity」クラスのインスタンスとなっています

# Class クラスのスーパークラスを選択肢の中から一つ選択してください。

A: Object

B: Module

C: BasicObject

D: Class

# 答え：B

# 次のコードの実行結果を選択肢から一つ選択してください。
module Mixin
  def self.greet
    puts "Hello World!"
  end
end

class SomeClass
  include Mixin
end

A: Mixin.greet は Hello World!,を 出力し,SomeClass.greet は例外を発生させる

B: Mixin.greet は例外を発生させ, SomeClass.greet は Hello World!を出力する

C: Mixin.greet も SomeClass.greet Hello World!を出力する

D: Mixin.greet も SomeClass.greet も例外を発生させる

答え：A

# 期待される出力結果となるように、(1)に入る選択肢を一つ選択してください
module Mixin
  def greet
    puts "Hello World!"
  end
end

class SomeClass
  extend Mixin
end

__(1)__

[期待される出力結果]
Hello World!

# A: Mixin.greet

# B: SomeClass.new.greet

# C: SomeClass.greet

# D: `Mixin.new.greet
# 答え：C
# 解説
# extendメソッドはモジュールを単一のオブジェクトにミックスインするために使用されます。 クラス定義内で使用される場合、「extend」はクラス自体を指すため、MixInモジュールのメソッドはクラスメソッドとして使用可能になります。

# extendはどのオブジェクトでも使用できます。


# 期待される出力結果となるように、(1)に入る選択肢を一つ選んでください

class BaseClass
  private

  def greet
    puts "Hello World!"
  end
end

class ChildClass < BaseClass
  __(1)__
end


ChildClass.new.greet

[期待される出力]
Hello World!

A:

public :greet
B:

protected :greet
C:

def greet
  super
end
D:

alias_method :original_greet, :greet

def greet
  original_greet
end

# 答え：B

# 解説
# protectedメソッドは、同じクラスまたはその子孫のインスタンス内からのみ呼び出すことができます。

# 期待される出力結果となるように、(1)に入る選択肢を一つ選んでください

class Upcaser
  def initialize(value)
    @value = value
  end

  def +(other)
    self.class.new(@value + other.value)
  end

  def to_s
    @value.upcase
  end

  attr_reader :value
  __(1)__
end

puts Upcaser.new("Hello") + Upcaser.new("World")

[期待される出力結果]
HELLOWORLD

A: private :value

B: public :value

C: protected :value

D: static :value**

# 答え：B,C

# 解説
# -プライベートメソッドは、同じクラスのインスタンスであっても、別のオブジェクトから直接呼び出すことはできません。 -Rubyには`static`キーワードはありません。

# 次のコードの実行結果を選択肢から一つ選択してください
class TShirt
  SIZES = [:xs, :s, :m, :l, :xl, :xxl]

  include Comparable

  def initialize(size)
    @size = size
  end

  attr_reader :size

  def <=>(other)
    SIZES.index(size) <=> SIZES.index(other.size)
  end
end

medium = TShirt.new(:m)
large  = TShirt.new(:l)

p medium == large
p medium <  large
p medium <= large
p medium >  large
p medium >= large


A:

true
false
true
false
true
B:

false
true
true
false
false
C:

false
false
false
true
true
D:

false
false
false
false
false
E: An exception is raised.

# 答え：B

# example.com ホームページの内容をHTTP経由で読み取るために、(1)に入る選択肢を一つ選択してください

__(1)__

puts open("http://example.com").read


# A: require "uri"

# B: require "net/http"

# C: require "open3"

# D: `require "open-uri"

# 答え：D

# 解説
# OpenURI標準ライブラリはKernel＃openの機能を拡張して、HTTPベースのリソースをファイルのように扱うことを可能にします。Net :: HTTP標準ライブラリのラッパーです。

# 期待される出力結果となるように、(1)に入る選択肢を一つ選んでください

if __(1)__ == "Henry"
  puts "Hi Henry!!!"
else
  puts "Hello, stranger."
end

[期待される出力結果]
Hi Henry!!!


# A: ENV['EMPLOYEE_NAME']

# B: $env['EMPLOYEE_NAME']

# C: ENV[:EMPLOYEE_NAME]

# D: `$env[:EMPLOYEE_NAME]

# 答え：A

# 解説
# 環境変数は、変数名とその値の両方を文字列として表すハッシュのようなオブジェクトを参照する「ENV」定数を介してアクセスされます。
