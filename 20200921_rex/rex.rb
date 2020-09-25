# 問題 x 2
class C
  def self.m1
    200
  end
end

module R
  refine C do
    def self.m1
      100
    end
  end
end

using R

puts C.m1


# 選択肢
# 100と表示される

# 選択肢
# 200と表示される

# 選択肢
# 300と表示される

# 選択肢
# エラーが発生する


# Module#refineは無名のモジュールを作成します。ブロック内のselfは無名モジュールになります。

class C
end

module M
  refine C do
    self # 無名モジュールを指します
  end
end
# Refinementでクラスメソッドを再定義する場合は次のようにsingleton_classを使います。ブロックの中でself.m1としないのがポイントです。

class C
  def self.m1
    'C.m1'
  end
end

module M
  refine C.singleton_class do
    def m1
      'C.m1 in M'
    end
  end
end

using M

puts C.m1 # C.m1 in M と表示されます。
# この問題では、クラスメソッドは再定義していませんので200が表示されます。

# 問題 x 3
# 実行結果にある結果を得るようにXXXXに適したコードを選べ

arr = XXXX
arr.each do |i|
  p i
end
# 実行結果
apple
banana
orange


# 選択肢
# %a/apple banana orange/

# 選択肢
# %r/apple banana orange/

# 選択肢
# %w/apple banana orange/

# 選択肢
# %/apple banana orange/

# %は%記法といいます。

# %a/ /: このような記法はありません
# %/ /: ダブルクォート文字列
# %r/ /: 正規表現
# %w/ /: 要素が文字列の配列
