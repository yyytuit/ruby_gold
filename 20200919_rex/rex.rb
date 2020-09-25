# 18問 x 4
# 次のプログラムを実行するとどうなりますか

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
      CONST
    end
  end
end

p C.new.greet

# 例外が発生する

# "Good, night"と表示される

# "Good, evening"と表示される

# "Hello, world"と表示される

# ::演算子が先頭にあるとトップレベルから定数の探索を行います。
# モジュールMにあるクラスCはトップレベルにあるものを指します。

# greetメソッドにあるCONSTはクラスCにはありませんが、スーパークラスにあるか探索を行います。
# クラスBaseを継承していますので、"Hello, world"が表示されます。


# 19問 x 3
class S
  @@val = 0
  def initialize
    @@val += 1
  end
end

class C < S
  class << C
    @@val += 1
  end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)

# @@valに1加算しているタイミングは以下です。

# Cクラスの特異クラスを定義
# C.newの呼び出し
# S.newの呼び出し

# 問題 x 4

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

# 選択肢
# 100と表示される

# 選択肢
# 180と表示される

# 選択肢
# 175と表示される

# 選択肢
# 150と表示される


# クラス変数はレキシカルに決定されますが、定数と同じスコープです。

module M
  CONST = 100
  @@val = 200
end

module M
  p CONST # 100 と表示されます
  p @@val # 200 と表示されます
end
ただし、クラス変数は上位のスコープ（外側）まで探索は行いません。

module M
  CONST = 100
  @@val = 200
end

module M
  class C
    p CONST # 100 と表示されます
    p @@val # NameError
  end
end
# また、Module#<はクラスの継承関係を比較することが出来ます。
# 継承をしているように見えますが、if文では継承関係を比較しています。

# Module#<はレシーバーが引数の子孫である場合にtrueを返します。

# 問題にあるクラス変数はそれぞれ次のように計算されます。

module M
  @@val = 75

  class Parent
    @@val = 100
  end

  class Child < Parent
    @@val += 50 # @@val = 100 + 50
  end

  if Child < Parent
    @@val += 25 # @@val = 75 + 25
  else
    @@val += 30 # @@val = 75 + 30
  end
end

p M::Child.class_variable_get(:@@val)
# この問題は150が表示されます。


# 問題 x 4

class C
  protected
    def initialize
    end
  end

  p C.new.methods.include? :initialize

  # 選択肢
  # 警告が表示される

  # 選択肢
  # エラーが発生する

  # 選択肢
  # falseと表示される

  # 選択肢
  # trueと表示される

# protectedメソッドは仲間クラス(自クラスかサブクラスのレシーバー)へ公開されているが、それ以外のクラスには隠蔽されています。
# 仲間クラスから参照するために、メソッドとしては公開されています

