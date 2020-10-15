期待される出力結果となるように、(1)に入る選択肢を一つ選んでください

class ShoppingList
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def __(1)__
    @items.map { |e| "- #{e} " }.join("\n")
  end
end

list = ShoppingList.new

list.add_item("Milk")
list.add_item("Bread")
list.add_item("Eggs")

puts list

[期待される出力]
- Milk
- Bread
- Eggs

A: to_s

B: to_str

C: inspect

D: `puts

答え：A
解説
多くのRubyメソッド（ Kernel＃putsを含む）は、オブジェクトを文字列表現に変換するためにto_sを呼び出します。
Object＃to_sのデフォルトの実装は、次のような単純で一般的な出力を生成します。

＃<ShoppingList：0x007fb651918610>

to_sメソッドが他のオブジェクトでオーバーライドされている場合、この設問に示すように、オブジェクトのより良い文字列表現を提供するために使用できます。
