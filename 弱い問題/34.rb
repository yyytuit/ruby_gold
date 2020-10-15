次のプログラムを実行するとどうなりますか

characters = ["a", "b", "c"]

characters.each do |chr|
  chr.freeze
end

upcased = characters.map do |chr|
  chr.upcase
end

p upcased
選択
選択肢
例外が発生する

選択肢
["a", "b", "c"]と表示される

選択肢
["A", "B", "C"]と表示される

選択肢
["d", "e", "f"]と表示される

freezeはオブジェクトの破壊的な変更を禁止します。

char = "a"
char.freeze
p char.upcase! # 例外発生
問題では配列の各要素を破壊的な変更を禁止しています。さらにその要素をupcaseで大文字に変換していますが、破壊的な変更ではないため例外は発生しません。

["A", "B", "C"]がこの問題の答えです。
