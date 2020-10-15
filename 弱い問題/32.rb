問題
次のコードを実行するとどうなりますか

class C
  @val = 3
  attr_accessor :val
  class << self
    @val = 10
  end
  def initialize
    @val *= 2 if val
  end
end

c = C.new
c.val += 10

p c.val
選択肢
13と表示される

選択
選択肢
16と表示される

選択肢
20と表示される

選択肢
エラーになる

問題のコードは、13行目でc.valがnilになり、実行エラーになります。

2行目の@valはクラスインスタンス変数といい、特異メソッドからアクセスすることができます。

3行目の@valは特異クラスのクラスインスタンス変数です。
この値にアクセスするためには以下のようにアクセスします。

class << C
  p @val
end
13行目のc.valはattr_accessorよりアクセスされます。
initializeメソッドで初期化が行われていないため、nilが返されます。

以下のコードは問題コードに行番号をつけています。

 1: class C
 2:   @val = 3
 3:   attr_accessor :val
 4:   class << self
 5:     @val = 10
 6:   end
 7:   def initialize
 8:     @val *= 2 if val
 9:   end
10: end
11: 
12: c = C.new
13: c.val += 10
14: 
15: p c.val
