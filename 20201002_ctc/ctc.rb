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


[実行結果]
foo
 1．	foo
 2．	Foo.foo
 3．	self.foo
 4．	obj.foo

#  解答：１
#  解説
#  private以降で定義されたメソッドはそのクラス、またはサブクラス内でのみ使用することができます。
#  そのメソッドを使用する時にはレシーバを指定することができません。

[コード]
 class Foo
   def foo
    __(1)__.bar
  end
  def bar
    puts "bar"
   end
 end
 Foo.new.foo


[実行結果]
 bar
	1．	Foo
	2．	it
	3．	self
	4．	this

# 解答：３
# 解説
# クラス内で定義したメソッドは、そのクラスのインスタンスから呼び出すことができます。
# インスタンスメソッド内で「self」というキーワードを使用すれば、メソッドを呼び出したオブジェクト自身を参照することができます。
# 「it」、「this」といったキーワードはありません。

[コード]
 class Hello
   def greet
     "Hello "
   end
 end
 class World < Hello
   def greet
     __(1)__ + "World"
   end
 end
 puts World.new.greet


[実行結果]
 Hello World
	1．	self
	2．	super
	3．	greet
	4．	override

# 解答：２
# 解説
# 親クラスの同名のメソッドを子クラスから呼び出す場合は「super」というキーワードを使用します。

[コード]
 module M
   CONST = "HELLO"
 end
 puts __(1)__


[実行結果]
 HELLO
	1．	::M::CONST
	2．	CONST
	3．	M
	4．	M.CONST

  # 解説
  # 定数にアクセスする場合「::」という記号を使用します。
  # モジュールによって定数の名前空間が分かれておりますので、「モジュール::定数」の形式でアクセスします。
  # また、モジュールやクラスなどの定義の一番外側の領域をトップレベルと呼びます。
  # トップレベルより定数にアクセスする場合は「::モジュール::定数」という形式でアクセスすることができます。

  [コード]
  class Error1 < StandardError; end
  class Error2 < Error1; end
  begin
   raise Error2
  rescue Error1 => ex
   puts ex.class
  end
   1．	Error1
   2．	Error2
   3．	StandardError
   4．	何も出力されない

  #  解答：２
  #  解説
  #  rescue節で捕捉できる例外は、指定した例外クラスと、そのクラスのサブクラスです。
  #  この場合、捕捉する例外としてError1を指定していますが、Error1のサブクラスとして定義されたError2の例外がraiseメソッドで発生されているため、Error2の例外を捕捉することができます。

# rubyに標準で存在する定数ではないものを選択してください。
	1．	ENV
	2．	ARGV
	3．	ARGF
	4．	NULL
# 解答：４
# 解説
# ENVは環境変数を表すオブジェクトです。
# ARGVはコマンドライン引数を表すオブジェクトです。
# ARGFはコマンドライン引数に指定されたファイルを表すオブジェクトです。

[コード]
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


[実行結果]
 foo
	1．	foo
	2．	Foo.foo
	3．	self.foo
	4．	obj.foo
  # 解答：２
  # 解説
  # protected以降で定義されたメソッドは、そのクラスとサブクラスのインスタンスから呼び出すことができます。
  # しかし、クラスをレシーバとして呼び出すことはできませんので、「Foo.foo」ではエラーになります。

  [コード]
 class Foo
   def __(1)__
    puts "foo"
  end
 end
 Foo.foo


[実行結果]
 foo
	1．	class.foo
	2．	this.foo
	3．	Foo.foo
  4．	foo

  # 解答：３
  # 解説
  # クラスメソッドはクラスをレシーバにして呼び出すことができます。
  # クラスメソッドは「クラス.メソッド」の形式で定義できます。

  [コード]
  class Foo
    def bar
      self.foo
    end
    __(1)__
    def foo
      puts "foo"
    end
  end
  Foo.new.bar

 [実行結果]
  foo
   1．	public
   2．	protected
   3．	private
   4．	なにも記述されない

  #  解答：３
  #  解説
  #  privateメソッドはレシーバを指定して呼び出すことはできません。
  #  また何も記述しない場合はpublicメソッドになりますので、なにも記述しなくてもfooメソッドを呼び出すことができます。

  [コード]
 char = { :a => "A" }.freeze
 char[:a] = "B"
 p char
	1．	"A"
	2．	"B"
	3．	エラーが発生する
  4．	nil

# 解答：３
# 解説
# freezeメソッドはオブジェクトを変更不可能にするメソッドです。
# ハッシュオブジェクトの値を変更しようとしている行でエラーが発生し、プログラムが終了します。

[コード]
 sum = Proc.new{|x, y| x + y}
 puts __(1)__


[実行結果]
 3
	1．	sum.call(1, 2)
	2．	sum(1, 2).call
	3．	sum(1, 2)
  4．	sum
  # 解答：１
  # 解説
  # Proc.newではブロックで指定した手続きを表すオブジェクトです。
  # 手続きを呼び出す時はProcオブジェクトに対してcallメソッドを呼びます。
  # ブロック引数はcallメソッドの引数で渡すことができます。

#   stringioライブラリの説明として正しいものを選択してください。
# 	1．	文字列をIOオブジェクトのように扱うことができる
# 	2．	文字列をファイル入出力専用で扱うことができる
# 	3．	StringIOクラスはIOクラスのサブクラスである
# 	4．	文字列をファイルに読み書きすることができる
# 解答：１

# [コード]
#  require 'yaml'
#  dir = <<EOY
#  file1:
#    name: file1.txt
#    data: text
#  EOY
#  p YAML.load(dir)
# 	1．	{"file1"=>{"name"=>"file1.txt", "data"=>"text"}}
# 	2．	{"file1"=>["name", "file1.txt", "data", "text"]}
# 	3．	["file1", ["name", "file1.txt", "data", "text"]]
#   4．	["file1", ["name", "file1.txt"], ["data", "text"]]

#  解答：１
# 解説
# yamlライブラリを使用すれば、人間が読めるテキスト形式でオブジェクトを表現することができます。
# 問題中のコードでは、まずハッシュのキーを指定し、さらにインデントでハッシュを指定しています。

[コマンドライン]
 $ ruby __(1)__ 'p 1024 * 5'


[実行結果]
 5120
	1．	-r
	2．	-v
	3．	-e
	4．	-s
  解答：３
  解説
  -eオプションは引数で指定した文字列を評価して、結果を出力するオプションです。

  ary = Array.new(3, "a")
  ary[0].next!
  p ary
   1．	["a", "a", "a"]
   2．	["b", "a", "a"]
   3．	実行時にエラーになる
   4．	["b", "b", "b"]

  #  解答：４
  #  解説
  #  Array.newは配列オブジェクトを生成します。
  #  newメソッドには2つの引数を指定することができ、1つ目には配列の要素数、2つ目には要素の初期値を指定します。

  #  問題文の「Array.new(3, "a")」では「["a", "a", "a"]」という配列が生成されます。
  #  ここでの各要素は同じオブジェクトを参照することにご注意ください。

  [コード]
  1: obj = Object.new
  2: def obj.hello
  3:  puts "hello"
  4: end
  5: obj.hello
  6: Object.new.hello
   1．	hello
 hello
   2．	hello
 nil
   3．	2行目で文法エラーが発生する
   4．	6行目でエラーが発生する

#  解答：４
#  解説
#  Rubyには特定のオブジェクトにのみメソッドを定義することができます。
#  これを特異メソッドと呼びます。特異メソッドは問題文のように「オブジェクト.メソッド名」のように定義します。

1．	メソッドのアクセス制限を指定しなかった場合、デフォルトでpublicになる
2．	メソッドのアクセス制限を指定しなかった場合、デフォルトでprotectedになる
3．	メソッドのアクセス制限を指定しなかった場合、デフォルトでprivateになる
4．	メソッドのアクセス制限を省略することはできない

# 解答：１
# 解説
# メソッド定義時にpublic、protected、privateの３つのアクセス制限を指定することができます。アクセス制限を指定しなかった場合は、デフォルトでpublicになり、メソッドが公開されます。

[コード1]
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


 [コード2]
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
	1．	[コード1]
foo
[コード2]
bar
	2．	[コード1]
bar
[コード2]
foo
	3．	[コード1]
foo
[コード2]
エラーになる
	4．	[コード1]
エラーになる
[コード2]
foo

# 解答：４
# 解説
# コード１でfooメソッドは未定義化されておりますのでメソッド呼び出し時にエラーになります。
# コード2では、メソッドの未定義化にremove_methodを使用しておりますが、このメソッドはスーパークラスに同名のメソッドがある場合にそれが呼ばれるので、エラーになりません。

[コード]
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
	1．	foo
	2．	foobar
	3．	実行時にエラーになる
  4．	bar

# 解答：２
# 解説
# aliasはメソッドに別名をつけるためのキーワードです。
# undefはメソッドを未定義化するためのキーワードです。
# 問題文中のコードでは、fooメソッドが定義された後に未定義化されておりますので、fooメソッドの呼び出しでは、superによって問題なく親クラスの同名のメソッドが呼ばれます。

[コード]
 class Person
  def initialize(name)
   @name = name
  end
  def __(1)__
   "My name is #{@name}"
  end
 end
 p Person.new("taro")


[実行結果]
 My name is taro.

 1．	p
 2．	to_s
 3．	inspect
 4．	toString

#  解答：３
#  解説
#  inspectメソッドはpメソッドでオブジェクトそのものを出力した際の文字列表現を指定するメソッドです。

FileTestモジュールに存在しないメソッドを選択してください。
	1．	file?
	2．	directory?
	3．	socket?
	4．	child?
解答：４
解説
FileTestモジュールはファイルやディレクトリの検査を行う機能をまとめたモジュールです。

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
	1．	foofoofoo
	2．	barbarbar
	3．	foofoofoo
      barbarbar
	4．	barbarbar
      foofoofoo

解答：４

