# 答え 2 4

# 次のプログラムは"Hello, world"と表示します。
# 同じ結果になる選択肢はどれですか（複数選択）
module M
  CONST = "Hello, world"
  def self.say
    CONST
  end
end
p M::say


# 選択肢
# module M
#   CONST = "Hello, world"
# end
# module M
#   def self.say
#     CONST
#   end
# end
# p M::say

# 選択肢
# module M
#   CONST = "Hello, world"
# end

# M.instance_eval(<<-CODE)
#   def say
#     CONST
#   end
# CODE
# p M::say

# 選択肢
# module M
#   CONST = "Hello, world"
# end
# class << M
#   def say
#     CONST
#   end
# end
# p M::say

# 選択肢
# module M
#   CONST = "Hello, world"
# end
# M.module_eval(<<-CODE)
#   def self.say
#     CONST
#   end
# CODE
# p M::say


# 定数の定義はメモリ上にあるテーブルに管理されます。
# モジュールMを別々に書いたとしてもテーブルを参照して値を取得できます。

# module M
#   CONST = "Hello, world"
# end

# module M
#   def self.say
#     CONST
#   end
# end

# p M::say
# instance_evalの引数に文字列を指定するとネストの状態はモジュールMの特異クラスになります。
# CONSTはモジュールMにのみありますので、例外が発生します。

# module M
#   CONST = "Hello, world"
# end

# M.instance_eval(<<-CODE)
#   def say
#     CONST
#   end
# CODE

# p M::say
# 特異クラス定義のコンテキストでは、ネストの状態はモジュールMの特異クラスになります。
# CONSTはモジュールMにのみありますので、例外が発生します。

# module M
#   CONST = "Hello, world"
# end

# class << M
#   def say
#     CONST
#   end
# end

# p M::say
# module_evalの引数に文字列を指定するとネストの状態はモジュールMになります。
# CONSTはモジュールMにありますので値を取得できます。

# module M
#   CONST = "Hello, world"
# end

# M.module_eval(<<-CODE)
#   def self.say
#     CONST
#   end
# CODE

# p M::say
