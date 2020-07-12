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

# 解説
# ::演算子が先頭にあるとトップレベルから定数の探索を行います。
# モジュールMにあるクラスCはトップレベルにあるものを指します。

# greetメソッドにあるCONSTはクラスCにはありませんが、スーパークラスにあるか探索を行います。
# クラスBaseを継承していますので、"Hello, world"が表示されます。
