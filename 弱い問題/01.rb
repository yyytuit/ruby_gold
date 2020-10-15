# 次のプログラムは"Hello, world"と表示します。
# 同じ結果になる選択肢はどれですか（複数選択）
# 答え 2 3

module M
  CONST = "Hello, world"

  class C
    def awesome_method
      CONST
    end
  end
end

p M::C.new.awesome_method


# 選択
# 1
module M
  CONST = "Hello, world"
end

class M::C
  def awesome_method
    CONST
  end
end

p M::C.new.awesome_method
# 選択肢
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
# 選択
# 選択肢
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
# 選択肢
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

# 解説
定数の参照はレキシカルに行われます。
#M::C#awesome_methodのコンテキストにCONSTがないため例外が発生します。

module M
  CONST = "Hello, world"
end

class M::C
  def awesome_method
    CONST
  end
end

p M::C.new.awesome_method

# class_evalにブロックを渡した場合は、ブロック内のネストはモジュールMになります。
# そのコンテキストから定数を探しますので"Hello, world"が表示されます。

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

# class_evalに文字列を渡した場合のネストの状態はクラスCです。
# CONSTはクラスCにありますので"Hello, world"が表示されます。

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

# class_evalにブロックを渡した場合は、ブロック内のネストはモジュールMになります。
# そのコンテキストから定数を探しますがないため例外が発生します。

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
