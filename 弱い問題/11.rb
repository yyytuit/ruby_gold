# 正解4
m = Module.new

CONST = "Constant in Toplevel"

_proc = Proc.new do
  CONST = "Constant in Proc"
end

m.instance_eval(<<-EOS)
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
# "Constant in Toplevel"と表示される

# 選択肢
# "Constant in Proc"と表示される

# 選択肢
# "Constant in Module instance"と表示される

# メソッドconstは特異クラスで定義されていますので、実行することができます。
# その中で参照している定数CONSTはレキシカルに決定されますので、"Constant in Module instance"が表示されます。

# instance_evalはブロックを渡す場合と、文字列を引数とする場合でネストの状態が異なります。
# ブロックを渡した場合はネストは変わりませんが、文字列を引数とした場合は期待するネストの状態になります。ネストが変わらない状態で定数の代入を行うと、再代入になり警告が表示される場合があります。
# 例えば、次のプログラムではmodule_evalに文字列を引数とするとモジュールを再オープン、または定義したネストと同じです。


# 問題 x 1
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
