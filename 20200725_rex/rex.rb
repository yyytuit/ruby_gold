# 4問 x ?
# 次のプログラムはEnumerator::Lazyを使っています。
# 先頭から5つの値を取り出すにはどのメソッドが必要ですか

(1..100).each.lazy.chunk(&:even?)

# 選択肢
# take(5)
# 選択肢
# take(5).force
# 選択肢
# first(5)
# 選択肢
# first(5).force

# 値を取り出すには、Enumerator::Lazy#forceまたはEnumerator::Lazy#firstを呼び出す必要があります。

# 問題文には「先頭から5つ」とあるので、first(5)として取り出します。
# また、Enumerator::Lazy#forceで問題文の通りにするにはEnumerator::Lazy#takeも利用します。

# Enumerator::Lazy#takeはEnumerable#takeと違いEnumerator::Lazyのインスタンスを戻り値にします。
# そのインスタンスからEnumerator::Lazy#forceで実際の値を取り出します。

# 8問 x 4
class C
  def m1
    400
  end
end

module M
  refine C do
    def m1
      100
    end
  end
end

class C
  using M
end

puts C.new.m1

# 選択肢
# 100と表示される

# 選択肢
# 200と表示される

# 選択肢
# エラーになる

# 選択肢
# 400と表示される
# Refinementは有効化したスコープのみに影響を与えることが出来ます。
# この問題ではクラスオープンした際にusingでRefinementを有効化していますが、
# スコープ外は無効になります。

# よって、puts C.new.m1とした結果は400になります。

# 10問 x 4
class C
  public
    def initialize
    end
  end

  p C.new.private_methods.include? :initialize

  # 選択肢
  # 警告が表示される

  # 選択肢
  # エラーが発生する

  # 選択肢
  # falseと表示される

  # 選択肢
  # trueと表示される
  # initializeはprivateなどでアクセス修飾子をつけたとしても、privateから変わることはありません。


# 19問 x 1
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

# 選択肢
# 例外が発生する

# 選択肢
# "Constant in Module instance"と表示される

# 選択肢
# "Constant in Proc"と表示される

# 選択肢
# "Constant in Module instance"と表示される

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

# 21問 x 3
module SuperMod
end

module SuperMod::BaseMod
  p Module.nesting
end

# 選択肢
# [SuperMod, BaseMod]

# 選択肢
# [SuperMod, SuperMod::BaseMod]

# 選択肢
# [SuperMod::BaseMod]

# 選択肢
# [BaseMod]
# Module.nestingはネストの状態を表示します。

# 次のプログラムを実行すると、[SuperMod]と表示されます。

module SuperMod
  p Module.nesting
end
# モジュールがネストされた場合は、ネストの状態をすべて表示します。
# SuperMod::BaseModのようにプログラムを書くとモジュールSuperModの内側にモジュールBaseModがあることを表現することが出来ます。
# インデントして別々に書いた場合に比べて、プレフィックスがある場合は内側にあるモジュールしかネストの状態は表示されません。

module SuperMod
  p Module.nesting # [SuperMod]
end

module SuperMod
  module BaseMod
    p Module.nesting # [SuperMod::BaseMod, SuperMod]
  end
end

module SuperMod::BaseMod
  p Module.nesting # [SuperMod::BaseMod]
end
# この問題は[SuperMod::BaseMod]が表示されます。

# 25問 x 1

begin
  print "liberty" + :fish.to_s
rescue TypeError
  print "TypeError."
rescue
  print "Error."
else
  print "Else."
ensure
  print "Ensure."
end

# 選択肢
# libertyfishElse.Ensure.
# と表示される

# 選択肢
# libertyfish
# Else.
# Ensure.
# と表示される

# 選択肢
# libertyfishEnsure.
# と表示される

# 選択肢
# Ensure.
# と表示される

# :fishはSymbolクラスのオブジェクトです。
# Symbol#to_sでStringオブジェクトが返されます。

# String#+の引数はStringクラスを期待します。
# Stringクラス以外のオブジェクトが渡された場合は、TypeErrorを発生させます。

# エラーを受け取るためにはrescueで、例外を受け取った際の処理を記述します。
# エラーが発生しなかった場合の処理を行うにはelseを用います。
# エラー発生有無に関わらず、必ず実行される、後処理を行うにはensureを用います。

# 29問 x 4

def foo(arg1:100, arg2:200)
  puts arg1
  puts arg2
end

option = {arg2: 900}

foo arg1: 200, *option

# 選択肢
# 200
# 900
# と表示される

# 選択肢
# 900
# 200
# と表示される

# 選択肢
# 100
# 200
# と表示される

# 選択肢
# エラーになる

# キーワード引数へHashオブジェクトを渡すことができます。
# Hashの中身を渡す必要があるので、変数の前に**を付加します。

# 35問 x 2
module M
  def self.class_m
    "M.class_m"
  end
end

class C
  include M
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

# 問題コードの注意すべき点は以下の通りです。

# includeはModuleのインスタンスメソッドをMix-inするメソッドです。
# def self.class_mと宣言すると、特異クラスのメソッドになります。
# C.methodsはCの特異メソッドを表示します。
# よって、Cにはclass_mが追加されません

# 49問 x 3
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

# 選択肢
# "Scope::Base#name"
# "Scope::Inherited#name"
# 選択肢
# "Base#name"
# "Scope::Base#name"
# 選択肢
# "Scope::Inherited#name"
# "Scope::Base#name"
# 選択肢
# "Scope::Inherited#name"
# "Base#name"

# クラスInheritedの親クラスBaseがどのように決定されるかがこの問題のポイントです。
# クラスはRubyでは定数です。定数の探索はレキシカルスコープを利用します。

# 親クラスBaseの探索はモジュールScopeから始まります。
# レキシカルスコープにクラス（定数）Baseが見つかったので、クラスInheritedの親クラスBaseはScope::Baseとなります。

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

  class Inherited < Base # クラスScope::Baseとして解釈される
    def name
      p 'Scope::Inherited#name'
      super
    end
  end
end
# もし、クラスBaseがクラスInheritedより前に定義されていないのであれば動作が変わります。
# 継承を定義した時点でScope::BaseをRubyは見つけることができないので、親クラスBaseはトップレベルにあるクラスを参照します。

class Base
  def name
    p 'Base#name'
  end
end

module Scope
  class Inherited < Base # トップレベルにあるクラスBaseとして解釈される
    def name
      p 'Scope::Inherited#name'
      super
    end
  end

  class Base
    def name
      p 'Scope::Base#name'
    end
  end
end

inherited = Scope::Inherited.new
inherited.name

# 結果は次の通り
# "Scope::Inherited#name"
# "Base#name"
