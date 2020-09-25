# 26問 x 1,4
# 次のプログラムを実行すると215が表示されます。
# __(1)__に適切な選択肢を選んでください。

val = 100

def method(val)
  yield(15 + val)
end

_proc = Proc.new{|arg| val + arg }

p method(val, __(1)__)

# &_proc.to_proc

# _proc.to_proc

# _proc

# &_proc

# Procオブジェクトをメソッドで実行するにはブロックに変換する必要があります。
# &をProcオブジェクトのプレフィックスにすることでブロックに変換することが出来ます。

# また、to_procメソッドはProcオブジェクトを生成して返します。Procオブジェクトをレシーバにto_procを実行するとレシーバ自身が返ってきます。

# この問題の答えは、&_proc.to_procと&_procです。

# 36問 x 2
# 次のコードを実行するとどうなりますか

module M
  def self.class_m
    "M.class_m"
  end
end

class C
  include M
end

p C.methods.include? :class_m

# trueが表示される

# falseが表示される

# nilが表示される

# 警告が表示される

# 問題コードの注意すべき点は以下の通りです。

# includeはModuleのインスタンスメソッドをMix-inするメソッドです。
# def self.class_mと宣言すると、特異クラスのメソッドになります。
# C.methodsはCの特異メソッドを表示します。
# よって、Cにはclass_mが追加されません。

# 48問 x 3
# 次のプログラムを実行するとどうなりますか

array = ["a", "b", "c"].freeze

array.each do |chr|
  chr.upcase!
end

p array


# 例外が発生する

# ["a", "b", "c"]と表示される

# ["A", "B", "C"]と表示される

# ["d", "e", "f"]と表示される

# freezeはオブジェクトの破壊的な変更を禁止します。
# 次のプログラムでは配列の破壊的な変更を禁止しますので、例外が発生します。

array = ["a", "b", "c"].freeze
array << "d" # 例外発生

p array

# 配列の破壊的な変更を禁止しますが、配列の要素の破壊的な変更は禁止していません。
# したがって、upcase!を実行しても例外は発生しません。

# ["A", "B", "C"]がこの問題の答えです。
