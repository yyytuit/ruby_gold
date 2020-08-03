# 4問 1 4
# Rubyで使用可能なオプションではないものを選択しなさい(複数)。

# 選択肢
# -t

# 選択肢
# -l

# 選択肢
# -p

# 選択肢
# -f

# -l: 各行の最後に String#chop!を実行します。
# -p: -nと同じだが$_を出力
# -t: このオプションはありません。
# -f: このオプションはありません。


# 6問 x 4
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

# 選択肢
# "010"と表示される

# 選択肢
# "001"と表示される

# 選択肢
# "100"と表示される

# 選択肢
# "011"と表示される

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

# p M::C.new.awesome_method # 例外が発生する
# 一方で同じレキシカルスコープにある場合は例外は発生しません。

module M
  CONST = "Hello, world"

  class C
    def awesome_method
      CONST
    end
  end
end

p M::C.new.awesome_method
# また、使われている定数の場所がネストされている場合は内側から順に定数の探索が始まります。
# レキシカルスコープに定数がない場合は、スーパークラスの探索を行います。

# クラスCbから最も物理的に近いのはM2::CONSTであるため答えは"011"になります。
# スーパークラスの探索はこの場合には行われません。

# 8問 x 1
module M
  def class_m
    "class_m"
  end
end

class C
  extend M
end

p C.methods.include? :class_m

# 選択肢
# trueが表示される

# 選択肢
# falseが表示される

# 選択肢
# nilが表示される

# 選択肢
# 警告が表示される

# extendは引数に指定したモジュールのメソッドを特異メソッドとして追加します。

# 問題のC.methods...は特異メソッドの一覧を取得します。


# 18問 x 3

class S
  def initialize
    puts "S#initialize"
  end
end

class C < S
  def initialize(*args)
    super()
    puts "C#initialize"
  end
end

C.new(1,2,3,4,5)

# 選択肢
# C#initialize
# と表示される

# 選択肢
# C#initialize
# S#initialize
# と表示される

# 選択肢
# S#initialize
# C#initialize
# と表示される

# 選択肢
# エラーになる

# superはスーパークラスと同名のメソッドが呼ばれます。
# 引数ありのメソッドでsuperを呼び出すと、引数ありのメソッドが呼ばれますが、そのメソッドが存在しない場合は、ArgumentErrorが発生します。
# 引数ありのメソッドで引数なしのスーパークラスを呼び出すには、super()と明示的に呼び出す必要があります。

# 22問 x 2
def hoge(*args, &block)
  block.call(args)
end

hoge(1,2,3,4) do |*args|
  p args.length < 0 ? "hello" : args
end

# 選択肢
# [[1],[2],[3],[4]]と表示される

# 選択肢
# [[1,2,3,4]]と表示される

# 選択肢
# "hello"と表示される

# 選択肢
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

# 24問 x 2
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
  include M
end

C.new.foo


# 選択肢
# C2#foo
# C#foo
# M#foo
# と表示される

# 選択肢
# C2#foo
# M#foo
# C#foo
# と表示される

# 選択肢
# M#foo
# C2#foo
# C#foo
# と表示される

# 選択肢
# エラーになる

# includeはモジュールのメソッドをインスタンスメソッドとして追加します。
# メソッド探索順はselfの後に追加されます。

# 34問 x 2
module SuperMod
  module BaseMod
    p Module.nesting
  end
end

# 選択肢
# [SuperMod, BaseMod]

# 選択
# [SuperMod, SuperMod::BaseMod]

# 選択肢
# [BaseMod, SuperMod]

# 選択肢
# [SuperMod::BaseMod, SuperMod]

# Module.nestingはネストの状態を表示します。

# 次のプログラムを実行すると、[SuperMod]と表示されます。

# module SuperMod
#   p Module.nesting
# end
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


# 35問 x 3
class Class
  def method_missing(id, *args)
    puts "Class#method_missing"
  end
end
class A
  def method_missing(id, *args)
    puts "A#method_missing"
  end
end
class B < A
  def method_missing(id, *args)
    puts "B#method_missing"
  end
end

B.dummy_method

# 選択肢
# エラーになる

# 選択肢
# A#method_missing
# 選択肢
# Class#method_missing

# 選択肢
# B#method_missing
# method_missingは、継承チェーンを辿った末にメソッドが見つからなかった場合に、呼び出されます。
# method_missingも継承チェーンを辿ります。

# 問題で、B.dummy_methodと呼び出しています。
# これは、Classクラスのインスタンスメソッドが呼ばれます。
# よって、Class#method_missingが出力されます
