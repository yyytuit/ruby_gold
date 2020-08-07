# 12問 x 4
module M
  def refer_const
    CONST
  end
end

module E
  CONST = '010'
end

class D
  CONST = "001"
end

class C < D
  include E
  include M
  CONST = '100'
end

c = C.new
p c.refer_const

# 選択肢
# "001"と表示される

# 選択肢
# "010"と表示される

# 選択肢
# "100"と表示される

# 選択肢
# 例外が発生する
# refer_constはモジュールMにありますが、CONSTはレキシカルに決定されるためモジュールMのスコープを探索します。
# この問題ではCONSTが見つからないため例外が発生します。

# 35問 x 1
class C
end

module M
  refine C do
    def m1(value)
      super value - 100
    end
  end
end

class C
  def m1(value)
    value - 100
  end
end

using M

class K < C
  def m1(value)
    super value - 100
  end
end

puts K.new.m1 400

# 選択肢
# 100と表示される

# 選択肢
# 200と表示される

# 選択肢
# 300と表示される

# 選択肢
# 400と表示される

# superを実行した場合にもRefinementが影響します。理解しやすいようにそれぞれのメソッドにコメントと計算の途中結果を追加しました。

class C
end

module M
  refine C do
    def m1(value)
      p "define m1 using Refinement"
      super value - 100 # 300 - 100
    end
  end
end

class C
  def m1(value)
    p "define m1 in C"
    value - 100 # 200 - 100
  end
end

using M # ここからRefinementが有効になる

class K < C
  def m1(value)
    p "define m1 in K"
    super value - 100 # 400 - 100
    # Refinementが有効なのでsuperはモジュールMにあるm1を参照する
  end
end

puts K.new.m1 400
# プログラムを実行するとコメントは次の順に表示されます。

# "define m1 in K"
# "define m1 using Refinement"
# "define m1 in C"
# superを実行したクラスの親クラスにRefinemnetがあれば同名のメソッドを探索して実行します。  
# さらに、Refinementのなかでsuperを実行するとRefinementの対象クラスのメソッドを探索します。


