#問題2 2,6 標準添付ライブラリ
a = 1.0+1
a = a+(1/2r)
a = a+(1+2i)
# 1.1行目で例外となる。
# 2.1行目でaの値がFloatインスタンスとなる。
# 3.2行目で例外となる。
# 4.2行目でaの値がRationalインスタンスとなる。
# 5.3行目で例外となる。
# 6.3行目でaの値がComplexインスタンスとなる。

# FloatインスタンスとRationalインスタンスの演算は、Floatインスタンスとなります。
# FloatインスタンスとComplexインスタンスの演算は、Complexインスタンスとなります。

# 問題3 4 オブジェクト思考
class A
  private
  def hoge
    puts "A"
  end
end
class B < A
  public :hoge
end
B.new.hoge

# 1.NoMethodErrorが発生する。

# 2.StandardErrorが発生する。

# 3. 何も表示されない

# 4. Aと表示される

# Aクラスのprivateメソッドhogeは、サブクラスBでpublicに再定義されています。


# 問題6 1,4,5
# xに記述す適切なコードを全て選びなさい。(複数選択可)

Thread. x do
end

# 1. start
# 2. run
# 3. kick
# 4. new
# 5. fork

# Threadクラスで、スレッドを生成し実行するメソッドはstart、new、fork

# 問題7 3 文法

# 以下のコードで、case文の比較に使用されている演算子はどれですか。

a = [1,"Hello",false]
a.each do |x|
  puts case x
  when String then "string"
  when Numeric then "number"
  when TrueClass,FalseClass then "boolean"
  end
end
# 1.=
# 2.==
# 3.===
# 4.class

# 問題11 1 文法
# 以下の実行結果になるように、Xとyに記述する適切なコードを選びなさい

while X.gets
  puts $_if$_=~/Ruby/
end
  Y
java programming
Ruby programming
C programming

# 実行結果
# Ruby programming

# 1. X DATA Y __END__
# 2. X $DATA Y __END__
# 3. X __DATA__ Y __END__
# 4. X DATA Y $END
# 5. X $DATA Y $END
# 6. X __DATA__ Y $END

# 解説：__END__以降に記述した内容は、FileオブジェクトDATAから読み出すことができます。

# 問題12 3 文法
# 以下の実行結果になるように、Xに記述する適切なコードを選びなさい。

def method
  puts "Hello,World"
end
  X
def method
  old_method
  puts "Hello,RubyWorld"
end
method

# 実行結果
# Hello,World
# Hello,RubyWorld

# 1.alias "old_method" "method"
# 2.alias "method" "old_method"
# 3.alias old_method method
# 4.alias method old_method

# 問題13 4 オブジェクト指向

class A
  @@x = 0
  class << self
    @@x = 1
    def x
      @@x
    end
  end
  def x
    @@x = 2
  end
end
class B < A
  @@x = 3
end
p A.x

# 1. 0が表示される。
# 2. 1が表示される。
# 3. 2が表示される。
# 4. 3が表示される。
# 5. 例外が発生する。

# 問題15 2 オブジェクト指向
class A
  $a = self
  def hoge
    $b = self
  end
end
a=A.new
print A == $a , A.new == $b

# 1.truetrue
# 2.truefalse
# 3.falsetrue
# 4.falsefalse

# 問題19 3,5 組み込みライブラリ
# 以下の実行結果になるように、Xに記述する適切なコードを全て選びなさい。(複数選択)

x = ["abc","defgk","lopq"]

p x.sort{|a,b| X }

# 実行結果

["abc","lopq","defgk"]

# 1. a<=>b
# 2. b<=>a
# 3. a.size<=>b.size
# 4. b.size<=>a.size
# 5. a.size - b.size
# 6. b.size - a.size

# 問題20 2 文法
# 以下の実行結果になるように、Xに記述する適切なコードを選びなさい。

tag = ->(t,msg){
  print "<#{t}>#{msg}</#{t}>"
 }
  tag.X(:p, "Hello,World")

# 実行結果
<p>Hello,World</p>

# 1. proc
# 2. call
# 3. resume
# 4. invoke

# 問題22 1 文法
class C1
  MSG = "msg1"
  MSG2 = "msg2"
  class C2
    MSG = "C2:msg1"
    puts MSG
    puts MSG2
  end
  puts MSG
  puts MSG2
end

# 1
# C2:msg1
# msg2
# msg1
# msg2

# 2
# constant_1.rb:5:warning: already initialized
# constant MSG
# C2:msg1
# msg2
# msg1
# msg2

# 3
# C2:msg1
# constant_1.rb:7: uninitialized constant
# C1::C2::MSG2 (NameError)

# 4
# 何も表示されない

問題23 ４ 文法
begin
exit
rescue StandardError
  puts "StandardError"
rescue SystemExit
  puts "SystemExit"
end
puts "End"

# 1 StandardError
# 2 SystemExit
# 3 StandardError
#   End
# 4 SystemExit
#   End
# 5 End

# 組み込み関数exitは、例外SystemExitを発生させます。これをrescueすれば、実行を継続します。rescueしなければ、プログラムを終了します。

# 問題24 1 標準添付ライプラリ
stringioライブラリの説明として適切な記述を全て選びなさい。

# 1. 文字列をIOオブジェクトと同じように扱える。
# 2. ファイル入出力専用の文字列である。
# 3. IOクラスのサブクラスである。
# 4. 文字列をファイルに読み書きできる。
# stringioライブラリは、文字列にIOオブジェクトと同じインタフェースを持たせるStringIOクラスを含んでいます。
# また、StringIOクラスはIOクラスを継承したクラスではありません。

# 問題25 2 オブジェクト指向

def foo
  puts "Hello"
end

1
class Object
  def foo
    puts "Hello"
  end
end

2
class Object
  private
  def foo
    puts "Hello"
  end
end

3
class Module
  def foo
    puts "Hello"
  end
end

4
class Module
  private
  def foo
    puts "Hello"
  end
end

# トップレベルはObjectクラスのオブジェクトです。トップレベルで定義されたメソッドの可視性はprivateです。
