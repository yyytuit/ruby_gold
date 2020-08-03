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

# 100と表示される

# 200と表示される

# 300と表示される

# エラーが発生する

# 解説
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

# puts C.m1 # C.m1 in M と表示されます。
# この問題では、クラスメソッドは再定義していませんので200が表示されます。
