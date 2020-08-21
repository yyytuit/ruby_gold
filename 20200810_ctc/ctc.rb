# 問1 x 1

class Foo
  def bar(obj=nil)
   __(1)__
  end
  private
  def foo
    puts "foo"
  end
end
Foo.new.bar(Foo.new)
# [実行結果]
#  foo

  # 1．	foo
	# 2．	Foo.foo
	# 3．	self.foo
	# 4．	obj.foo
  # private以降で定義されたメソッドはそのクラス、またはサブクラス内でのみ使用することができます。
  # そのメソッドを使用する時にはレシーバを指定することができません。
# 1でも3でも同じ結果になる。問題としてどうなのか?

# 6門 x 2
class Error1 < StandardError; end
 class Error2 < Error1; end
 begin
  raise Error2
 rescue Error1 => ex
  puts ex.class
 end


#  1．	Error1
#  2．	Error2
#  3．	StandardError
#  4．	何も出力されない
# rescue節で捕捉できる例外は、指定した例外クラスと、そのクラスのサブクラスです。
# この場合、捕捉する例外としてError1を指定していますが、Error1のサブクラスとして定義されたError2の例外がraiseメソッドで発生されているため、Error2の例外を捕捉することができます。

# 問10．以下の実行結果にならないようにするために__(1)__に当てはまるものを選択してください。
# 2

class Foo
  def bar(obj=nil)
   __(1)__
 end
 protected
 def foo
   puts "foo"
 end
end
Foo.new.bar(Foo.new)

# [実行結果]
#  foo

#  1．	foo
# 	2．	Foo.foo
# 	3．	self.foo
# 	4．	obj.foo
# protected以降で定義されたメソッドは、そのクラスとサブクラスのインスタンスから呼び出すことができます。
# しかし、クラスをレシーバとして呼び出すことはできませんので、「Foo.foo」ではエラーになります。

# 13門目xだが正解が再現しないのでパス

# 問16 x 3

char = { :a => "A" }.freeze
char[:a] = "B"
p char

#  1．	"A"
#  2．	"B"
#  3．	エラーが発生する
#  4．	nil

# 問16の解答と解説
# 解答：３
# 解説
# freezeメソッドはオブジェクトを変更不可能にするメソッドです。
# ハッシュオブジェクトの値を変更しようとしている行でエラーが発生し、プログラムが終了します。


# 問17 x 1

 sum = Proc.new{|x, y| x + y}
 puts __(1)__


# [実行結果]
#  3
# 	1．	sum.call(1, 2)
# 	2．	sum(1, 2).call
# 	3．	sum(1, 2)
# 	4．	sum
# 問17の解答と解説
# 解答：１
# 解説
# Proc.newではブロックで指定した手続きを表すオブジェクトです。
# 手続きを呼び出す時はProcオブジェクトに対してcallメソッドを呼びます。
# ブロック引数はcallメソッドの引数で渡すことができます。

# 問18．stringioライブラリの説明として正しいものを選択してください。
# 解答 1
# 	1．	文字列をIOオブジェクトのように扱うことができる
# 	2．	文字列をファイル入出力専用で扱うことができる
# 	3．	StringIOクラスはIOクラスのサブクラスである
# 	4．	文字列をファイルに読み書きすることができる

# 問23．以下のコマンドの実行結果から__(1)__に当てはまるものを選択してください。
# 解答 3

$ ruby __(1)__ 'p 1024 * 5'

# [実行結果]
#  5120
# 	1．	-r
# 	2．	-v
# 	3．	-e
# 	4．	-s
# 問23の解答と解説
# 解答：３
# 解説
# -eオプションは引数で指定した文字列を評価して、結果を出力するオプションです。


# 問27．以下のコードの実行結果として正しいものを選択してください。

 ary = Array.new(3, "a")
 ary[0].next!
 p ary

# 	1．	["a", "a", "a"]
# 	2．	["b", "a", "a"]
# 	3．	実行時にエラーになる
# 	4．	["b", "b", "b"]
# 問27の解答と解説
# 解答：４
# 解説
# Array.newは配列オブジェクトを生成します。
# newメソッドには2つの引数を指定することができ、1つ目には配列の要素数、2つ目には要素の初期値を指定します。

# 問題文の「Array.new(3, "a")」では「["a", "a", "a"]」という配列が生成されます。
# ここでの各要素は同じオブジェクトを参照することにご注意ください。

# 問28．以下の結果を出力するコードとして__(1)__に当てはまるものを選択してください。

class MyNum
  attr_reader :num
  def initialize(num)
   @num = num
  end
  __(1)__
 end


 num1 = MyNum.new(30)
 num2 = MyNum.new(10)
 num3 = MyNum.new(20)
 p [num1, num2, num3].sort.map{|n| n.num }


# [実行結果]
#  [10, 20, 30]
# 	1．	include Comparable
# 	2．	include Enumerable
# 	3．	def <=>(other)
# @num <=>other.num
# end
# 	4．	def sort(other)
# @num <=>other.num
# end
# 解答：３
# 解説
# 問題文のコードでは配列に対してsortメソッドを呼び出しています。
# sortメソッドは、配列の要素に対して<=>演算子を使用して比較します。

# 数値や文字列などの既存のオブジェクトに関しては、<=>演算子が定義されているので、sortメソッドを使用することができますが、作成したクラスのオブジェクトには、<=>演算子を定義する必要があります。

# 問30．以下のコードを実行したときの結果として正しいものを選択してください。

 a, b = [1, 2, 3]
 p a
 p b

# 1．	1、[2, 3]
# 2．	[1, 2]、3
# 3．	1、2
# 4．	[1, 2, 3]、nil
# 問30の解答と解説
# 解答：３
# 解説
# Rubyは多重代入をサポートしておりますので、一度に複数の変数に代入することができます。問題文のコードは下記のコードと同様です。

# a = 1
# b = 2

# 左辺の変数の数より、右辺の値の数の方が多い場合は残りの値を破棄します。


# 問32．以下のコードの説明として正しいものを選択してください。なお行の先頭に記述されているのは行番号です。

obj = Object.new
def obj.hello
  puts "hello"
end
obj.hello
 Object.new.hello

# 	1．	hello、hello
# 	2．	hello、nil
# 	3．	2行目で文法エラーが発生する
# 	4．	6行目でエラーが発生する
# 問32の解答と解説
# 解答：４
# 解説
# Rubyには特定のオブジェクトにのみメソッドを定義することができます。これを特異メソッドと呼びます。特異メソッドは問題文のように「オブジェクト.メソッド名」のように定義します。


# 問33．以下の結果を出力するコードとして__(1)__に当てはまるものを選択してください。

 def foo(__(1)__)
  puts arg
 end
 foo


# [実行結果]
#  default

# 	1．	arg:"default"
# 	2．	arg="default"
# 	3．	arg=>"default"
# 	4．	arg<="default"
# 問33の解答と解説
# 解答：２
# 解説
# メソッド定義時に引数にデフォルト値を指定することができます。デフォルト値の指定は「引数名=デフォルト値」という形式で指定します。

# 問34．以下のコードの説明として正しいものを選択してください。

#  class Foo
#   def foo
#    puts "foo"
#   end
#  end
#  class Foo
#   def bar
#    puts "bar"
#   end
#  end
# 	1．	2回目のFooクラスの定義でエラーが発生する
# 	2．	Fooクラスにはfooメソッドとbarメソッドが定義される
# 	3．	Fooクラスにはfooメソッドのみ定義される
# 	4．	Fooクラスにはbarメソッドのみ定義される
# 問34の解答と解説
# 解答：２
# 解説
# Rubyにはオープンクラスという特徴があり、一度定義したクラスに後からメソッドなどを追加することができます。

# 問40．以下のようなfile1.rbとfile2.rbがあります。file2.rbを実行した結果として正しいものを選択してください。

# [file1.rb]
 $var += 1


# [file2.rb]
 $var = 0
 require "file1.rb"
 require "file1.rb"
 puts $var

# 	1．	0
# 	2．	1
# 	3．	2
# 	4．	実行時にエラーが発生する
# 問40の解答と解説
# 解答：２
# 解説
# requireはライブラリを読み込むメソッドです。同一のファイルを指定しても2回読み込まれません。


# 問42．以下の2つのコードの実行結果の出力として正しいものを選択してください。
#  [コード1]
 class Foo
  def foo
   puts "foo"
  end
 end
 class Bar < Foo
  def foo
   puts "bar"
  end
 end
 class Bar
  undef_method :foo
 end
 Bar.new.foo


#  [コード2]
 class Foo
  def foo
   puts "foo"
  end
 end
 class Bar < Foo
  def foo
   puts "bar"
  end
 end
 class Bar
  remove_method :foo
 end
 Bar.new.foo

# 	1．	[コード1] foo
#       [コード2] bar
# 	2．	[コード1] bar
#       [コード2] foo
# 	3．	[コード1] foo
#       [コード2] エラーになる
# 	4．	[コード1] エラーになる
#       [コード2] foo
# 問42の解答と解説
# 解答：４
# 解説
# コード１でfooメソッドは未定義化されておりますのでメソッド呼び出し時にエラーになります。
# コード2では、メソッドの未定義化にremove_methodを使用しておりますが、このメソッドはスーパークラスに同名のメソッドがある場合にそれが呼ばれるので、エラーになりません。

# 問43．以下のコードの実行結果として正しいものを選択してください。

 class Foo
  def foo
   "foo"
  end
 end

 class Bar < Foo
  def foo
   super + "bar"
  end
  alias bar foo
  undef foo
 end
 puts Bar.new.bar

# 	1．	foo
# 	2．	foobar
# 	3．	実行時にエラーになる
# 	4．	bar
# 問43の解答と解説
# 解答：２
# 解説
# aliasはメソッドに別名をつけるためのキーワードです。
# undefはメソッドを未定義化するためのキーワードです。
# 問題文中のコードでは、fooメソッドが定義された後に未定義化されておりますので、fooメソッドの呼び出しでは、superによって問題なく親クラスの同名のメソッドが呼ばれます。

# 問47．FileTestモジュールに存在しないメソッドを選択してください。
# 	1．	file?
# 	2．	directory?
# 	3．	socket?
# 	4．	child?
# 問47の解答と解説
# 解答：４
# 解説
# FileTestモジュールはファイルやディレクトリの検査を行う機能をまとめたモジュールです。


# 問48．下記のコードの説明として正しいものを選択してください。

 class Foo
  def initialize(obj)
   obj.foo
  end
  def foo
   puts "foofoofoo"
  end
 end
 class Bar
  def foo
   puts "barbarbar"
  end
 end
 Foo.new(Bar.new)
# 	1．	このコードを実行すると「foofoofoo」と出力される
# 	2．	このコードを実行すると「barbarbar」と出力される
# 	3．	このコードを実行するとシンタックスエラーになる
# 	4．	このコードを実行すると呼び出されるメソッドが存在しないためエラーになる
# 問48の解答
# 解答：２

# 問49．下記のコードの実行結果として正しいものを選択してください。

 class Bar
  def foo
   puts "barbarbar"
  end
 end
 class Foo < Bar
  def initialize(obj)
   obj.foo
  end
  def foo
   puts "foofoofoo"
  end
 end
 Foo.new(Foo.new(Bar.new))

# 	1．	foofoofoo
# 	2．	barbarbar
# 	3．	foofoofoo
#       barbarbar
# 	4．	barbarbar
#       foofoofoo
# 問49の解答
# 解答：４

# 問51．以下のコードの説明として正しいものを選択してください。

 class Foo
  private
  def foo
   puts "foofoofoo"
  end
 end
 puts Foo.new.respond_to?(:foo)

# 	1．	このコードを実行すると「foofoofoo」が出力される
# 	2．	このコードを実行すると「true」が出力される
# 	3．	このコードを実行すると「false」が出力される
# 	4．	引数には文字列を指定すべきなので実行するとエラーになる
# 問51の解答と解説
# 解答：３
# 解説
# respond_to?メソッドは、レシーバが引数で指定した名前のpublicメソッドを持っているか調べるメソッドです。第2引数にtrueを指定すれば、指定した名前のprivateメソッドを持っているかを調べることができます。

# 問52．webrickライブラリの説明として正しいものを選択してください。
# 	1．	webrickは組込みライブラリなので「require 'webrick'」を記述しなくても使用できる
# 	2．	webrickライブラリは、Webサーバを実装するためのライブラリでRuby on Railsでも使用されている
# 	3．	webrickライブラリはSSL通信に対応していない
# 	4．	webrickライブラリを使用する場合は、gemなどでインストールする必要がある
# 問52の解答
# 解答：２

# 問53．以下のコードの説明として正しいものを選択してください。
# [コード]
#  require 'socket'
#  p TCPSocket.ancestors.member?(IO)
# 	1．	このコードを実行すると「true」が出力される
# 	2．	このコードを実行すると「false」が出力される
# 	3．	socketライブラリは組込みライブラリなので「require 'socket'」を記述する必要はない
# 	4．	socketライブラリにTCPSocketというクラスは存在しない
# 問53の解答と解説
# 解答：１
# 解説
# TCPSocketはIOクラスを継承しており、Fileクラスなどと同様な操作でソケットを扱うことができます。

# 問54．Threadライブラリを使用して新たなスレッドを生成するメソッドではないものを選択してください。
# 	1．	start
# 	2．	new
# 	3．	fork
# 	4．	open
# 問54の解答と解説
# 解答：４
# 解説
# Threadクラスのクラスメソッド、new、start、forkはそれぞれ新しいスレッドを生成するメソッドです。

# 問56．以下の実行結果を出力するコードとして__(1)__にあてはまるものを選択してください。

 class Log
  [:debug, :info, :notice].each do |level|
   __(1)__(level) do
    @state = level
   end
  attr_reader :state
 end
 log = Log.new
 log.debug  ; p log.state
 log.info   ; p log.state
 log.notice ; p log.state


# [実行結果]
#  :debug
#  :info
#  :notice
# 	1．	method_define
# 	2．	define_method
# 	3．	send
# 	4．	__send__
# 問56の解答と解説
# 解答：２
# 解説
# define_methodメソッドは引数で指定した名前のメソッドを定義するためのメソッドです。

# 問57．以下のコードを実行したときの出力結果として正しいものを選択してください。
var = lambda { puts "hello" }
 p var.class
	# 1．	エラーになる
	# 2．	Lambda
	# 3．	Proc
	# 4．	Object
# 問57の解答と解説
# 解答：３
# 解説
# lambdaキーワードはProcオブジェクトを生成するためのキーワードです。

# 問58．以下のコードの説明として正しいものを選択してください。
[コード]
 1: module M
 2:  def foo
 3:   puts "foo"
 4:  end
 5: end
 6:
 7: class Foo
 8:  extend M
 9: end
 10:
 11: Foo.new.foo
# 	1．	実行すると「foo」と出力される
# 	2．	8行目でエラーになる
# 	3．	11行目でエラーになる
# 	4．	実行すると「nil」と出力される
# 問58の解答と解説
# 解答：３
# 解説
# extendはモジュールで定義したメソッドをクラスメソッドとして追加しますので、メソッドを呼び出す場合は、「Foo.foo」と記述する必要があります。

# 問59．Marshalモジュールの説明として正しいものを選択してください。
# 	1．	Rubyで扱うすべてのオブジェクトをシリアライズすることができる
# 	2．	Marshalモジュールはそれ自身がオブジェクトをファイルに記録する機能を持っている
# 	3．	IOオブジェクトや特異メソッドを持つオブジェクトはシリアライズすることができない
# 	4．	Marshalモジュールは「require 'marshal'」を記述して使用することができる
# 問59の解答
# 解答：３

# 問60．標準添付ライブラリによって提供されていないクラスを選択してください。
# 	1．	TCPSocket
# 	2．	Thread
# 	3．	Test::Unit
# 	4．	Swap
# 問60の解答
# 解答：４
