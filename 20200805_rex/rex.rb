

# 7問x 23
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

# 19問x 3
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

# 選択肢
# 特異クラスに定数が見つからないため、例外が発生する

# 選択肢
# メソッドが見つからないため、例外が発生する

# 選択肢
# "Hello, world"と表示される

# 選択肢
# レキシカルスコープに定数が見つからないため、例外が発生する

# レキシカルスコープには定数はありません。その場合はスーパークラスを探索します。
# 特異クラスの継承関係にクラスCがありますので定数を見つけることができます。

# 参考：特異クラスの継承関係

# [#<Class:#<C:0x007fa4741607e0>>, C, Object, Kernel, BasicObject]
