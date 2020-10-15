次のプログラムを実行するとどうなりますか

class C
  CONST = "Hello, world"
end

$c = C.new

class D
  class << $c
    def say
      CONST
    end
  end
end

p $c.say
選択肢
特異クラスに定数が見つからないため、例外が発生する

選択肢
メソッドが見つからないため、例外が発生する

選択肢
"Hello, world"と表示される

選択
選択肢
レキシカルスコープに定数が見つからないため、例外が発生する

レキシカルスコープには定数はありません。その場合はスーパークラスを探索します。
特異クラスの継承関係にクラスCがありますので定数を見つけることができます。

参考：特異クラスの継承関係

[#<Class:#<C:0x007fa4741607e0>>, C, Object, Kernel, BasicObject]
