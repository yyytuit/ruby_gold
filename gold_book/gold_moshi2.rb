# 問題30 x 3 標準添付ライブラリ

array=[1,2,3].freeze
array+=[4,5]parray

# 1. 例外発生。
# 2. [1,2,3]と表示される。
# 3. [1,2,3,4,5]と表示される。
# 4. 何も表示されない。

# freezeはオブジェクトの内容の変更を禁止しますが、
# 参照変数自身は変更できます。
# 出題コードの場合、
# 変数arrayを破壊的に変更（concat,uniq!等）することはできませんが、
# 変数arrayが別の配列を参照するように変更することはできます。

# 問題31 x 1 3 オブジュエクト指向

# "B"と出力するコードを全て選びなさい。
# 1
class Object
  def self.const_missing a
    p "#{a}"
  end
end
B

# 2
class Module
  def self.const_missing a
    p "#{a}"
  end
end
B

# 3
class Hoge
  def self.const_missing a
    p "#{a}"
  end
end
Hoge::B

# 4
class Hoge
  def self.const_missing a
    p"#{a}"
  end
end
B

# const_missingは、クラスに定数が定義されていない場合に呼び出されるメソッドです。
# const_missingを定義することで、存在しない定数にアクセスした場合の任意の処理を実行できます。
# 選択肢2はModuleクラスにconst_missingを定義しています。
# 選択肢4はHogeクラスにconst_missingを定義しています。
# 呼び出している定数Bは、いずれもトップレベル、つまりObjectクラスの定数Bを呼び出しているため、デフォルトのconst_missing、すなわち例外NameErrorが発生します。

# 問題32 x 2,3 文法
以下の実行結果になるように、Xに記述する適切なコードを全て選びなさい。

class Err1 < StandardError; end
class Err2 < Err1; end
begin
  X
rescue Err1 => ex
  puts "Error"
end
実行結果
Error

1. raise StandardError
2. raise Err1
3. raise Err2
4. raise

# 問題34 x 1 オブジェクト指向

module M1
end
module M2
end
class Cls1
  include M1
end
class Cls2 < Cls1
  def foo
    p self.ancestors
  end
  include M2
end
Cls2.new.foo

# 1. 例外発生。
# 2. [Cls2,M2,Cls1,M1,Object,Kernel,BasicObject]
# 3. [Class,Module,Object,Kernel,BasicObject]
# 4. [Cls2,M2,Cls1,M1]

# ancestorsはModuleクラスのインスタンスメソッドです。
# レシーバがModuleクラスのインスタンス（つまりモジュール）、またはClassクラスのインスタンス（つまりクラス）の場合に有効です。
# 出題コードのself.ancestorsは、selfがCls2クラスのインスタンス（Classクラスのインスタンスではない）を示すため、例外NoMethodErrorが発生します。

# 問題37 x 1,2 オブジェクト指向
# 以下のコードを実行するとどうなりますか。すべて選びなさい。
module Mod
  def foo
    puts "Mod"
    super
  end
end
class Cls1
  def foo
    puts "Cls1"
  end
end
class Cls2 < Cls1
  prepend Mod
end
Cls2.new.foo
# 1. Modと表示。
# 2. Cls1と表示。
# 3. 例外発生。
# 4. 何も表示されない。

# prependで取り込まれたメソッドは元から定義されていたメソッドより先に呼び出されます。
# また、prependで呼び出されたモジュール内でsuperを呼び出すと、元から定義されていたメソッドが呼び出されます。

# 問題39 o 1,4 標準添付ライブラリ

# rdocコメントのマークアップとして適切な記述を全て選びなさい。
# 1. *word*で太字。
# 2._word_で等幅フォント。
# 3.+word+で斜体。
# 4.*で番号なしリスト。

# _word_はイタリック体を示します。+word+はタイプライタ体（等幅）を示します。

# 問題40 x 1,2 オブジェクト指向

# 以下の実行結果になるように、Xに記述する適切なコードを全て選びなさい。

class Hoge
  X
end
Hoge.method1

# 実行結果
# Hello,World.

# 1
def self.method1
  puts "Hello,World."
end

# 2
class << self
  def method1
    puts "Hello,World."
  end
end

# 3
class < self
  def method1
    puts "Hello,World."
  end
end

# 4
def class.method1
  puts "Hello,World."
end

# 問題41 x 1 標準添付ライブラリ

# 以下のコードを実行すると何が表示されますか。
d1 = Time.new
d2 = Time.new
p (d2 - d1).class

# 1. Float
# 2. Rational
# 3. Fixnum
# 4. Bignum

# Time同士の減算はFloat型になります。

# 問題43 o 1,3 組み込みライブラリ

# Kernelモジュールのfreezeメソッドについて適切な記述を全て選びなさい。（複数選択）

# 1. cloneはfreeze、taint、特異メソッドなどの情報も含めた完全な複製を作成する。
# 2. dupはfreeze、taint、特異メソッドなどの情報も含めた完全な複製を作成する。
# 3. クラスだけではなくモジュールもfreeze可能である。
# 4. モジュールをインクルードしたクラスをfreezeすることはできない。

# cloneとdupは、いずれもオブジェクトを複製します。
# cloneは、freeze、特異メソッドなどの情報も含めた完全な複製を返します。
# dupは、オブジェクトおよびtaint情報を含めた複製を返します。
# モジュールは、freeze可能です。
# モジュールをインクルードしたクラスもfreeze可能です。

# 問題44 x 4 オブジェクト指向

module Mod
  def Mod.foo
    puts "Mod"
  end
end
class Cls1
  include Mod
  def Cls1.foo
    puts "Cls1"
  end
end

class Cls2 < Cls1
  def Cls2.foo
    puts "Cls2"
  end
end
Cls2.new.foo

# 1. Modと表示される。
# 2. Cls1と表示される。
# 3. Cls2と表示される。
# 4. 例外発生。


# 問題45 o 1 4 組み込みライブラリ
# Kernelモジュールのcloneメソッドについて、適切な記述を全て選びなさい。（複数選択）

# 1. freeze、特異メソッドなどの情報も含めてコピーする。
# 2. freeze、特異メソッドなどの情報はコピーしない。
# 3. 参照先のオブジェクトもコピーされる。
# 4. 参照先のオブジェクトはコピーされない。

# Kernelモジュールのcloneメソッドは、freeze、taint、特異メソッドなどの情報も含めた完全なコピーを作成します。
# 参照先のオブジェクトはコピーしません（シャローコピー）。

# 問題47 x 1,2,4 組み込みライブラリ

# オブジェクトのマーシャリングについて、適切な記述を全て選びなさい。（複数選択）
# 1. IOクラスのオブジェクトはマーシャリングできない
# 2. 特異メソッドを持つオブジェクトはマーシャリングできない。
# 3. ユーザが作成したオブジェクトはマーシャリングできない。
# 4. 無名のクラスやモジュールはマーシャリングできない。

# システムの状態を保持するオブジェクト（IO、File、Dir、Socket）や特異メソッドを定義したオブジェクトは、マーシャリングできません。
# また、無名のクラスやモジュールもマーシャリングできません。

# 問題48 x 1,2 標準添付ライプラリ

# 以下の実行結果になるように、Xに記述する適切なコードをすべて選びなさい。

require "json"
h = { "a" => 1, "b" => 2 }
puts X
# 実行結果
# {"a":1,"b":2}

# 1. h.to_json
# 2. JSON.dump(h)
# 3. JSON.new(h)
# 4. JSON.to_json(h)

# 標準添付ライブラリのjsonはHashクラスにJSON文字列を生成するto_jsonメソッドを追加します。
# また、JSON.dumpメソッドでも同様のJSON文字列を生成します。

# 問題50 x 1,4 組み込みライブラリ
# 以下のコードを実行するとどうなりますか。全て選びなさい。

t1 = Thread.start do
  raise ThreadError
end
sleep
# 1. 例外が発生するが、メッセージを出力せずに停止状態になる。
# 2. 例外は発生せず、停止状態になる。
# 3. dオプションを付けた場合には、例外は発生せず停止状態になる。
# 4. dオプションを付けた場合には、例外発生のメッセージを出力して終了する。

# マルチスレッドで例外が発生し、その例外がrescueで処理されなかった場合、例外が発生したスレッドだけが警告なしで終了し、他のスレッドは実行を続けます。
# dオプションを付けるとデバックモードでの実行となり、いずれかのスレッドで例外が発生した時点でインタプリタ全体が中断します。
