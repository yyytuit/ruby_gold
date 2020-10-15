期待される出力結果になるように(1)に入る選択肢を一つ選んでください

class ShoppingList
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def __(1)__
    "ShoppingList (##{object_id})\n  @items: #{@items.inspect}"
  end
end

list = ShoppingList.new

list.add_item("Milk")
list.add_item("Bread")
list.add_item("Eggs")

p list

[期待される出力結果]
ShoppingList (#70338683731980)
  @items: ["Milk", "Bread", "Eggs"]

A: to_s

B: to_str

C: inspect

D: `p

答え：C

解説
Kernel＃pメソッドは、デバッグ目的で使用できる文字列を生成するために、引数でinspectを呼び出します。
Object＃inspectリストのデフォルトの機能は基本的な有用な情報を提供しますが、出力は特定のクラスまたはオブジェクトのメソッドをオーバーライドすることでカスタマイズできます。
