# 8問 x 2
def m1(*)
  str = yield if block_given?
  p "m1 #{str}"
end

def m2(*)
  str = yield if block_given?
  p "m2 #{str}"
end

m1 m2 do
  "hello"
end


# 選択肢
# "m2 hello"
# "m1 "
# と表示される

# 選択肢
# "m2 "
# "m1 hello"
# と表示される

# 選択肢
# "m2 "
# "m1 "
# と表示される

# 選択肢
# 警告が表示される

# 問題のコードで使用されているメソッド類は以下の通りです。

# Kernel#block_given?はブロックが渡された場合は、真になります。
# yieldはブロックの内容を評価します。
# { }はdo endよりも結合度が高い為、実行結果に差が出ます。
# 問題のコードは以下のように解釈されます。

# m1の引数と解釈されるため、m2の戻り値はm2が表示されます。
# m1へdo .. endのブロックが渡されます。よって、m1 helloが表示されます。
# m1(m2) do
#   "hello"
# end

# # 実行結果
# # "m2 "
# # "m1 hello"
# 問題のコードをdo ... endで置き換えた場合は以下の実行結果になります。

# m1 m2 {  # m1 (m2 { .. } ) と解釈される
#   "hello"
# }

# 実行結果
# m2 hello
# m1

# 16問x 4
class S
  @@val = 0
  def initialize
    @@val += 1
  end
end

class C < S
  class << C
    @@val += 1
  end
end

C.new
C.new
S.new
S.new

p C.class_variable_get(:@@val)

# 選択肢
# 3と表示される

# 選択肢
# 4と表示される

# 選択肢
# 5と表示される

# 選択肢
# 2と表示される

# @@valに1加算しているタイミングは以下です。

# Cクラスの特異クラスを定義
# C.newの呼び出し
# S.newの呼び出し

# 39問 x 1
class Company
  XXXX
  attr_reader :id
  attr_accessor :name
  def initialize id, name
    @id = id
    @name = name
  end
  def to_s
    "#{id}:#{name}"
  end
  YYYY
end

c1 = Company.new(3, 'Liberyfish')
c2 = Company.new(2, 'Freefish')
c3 = Company.new(1, 'Freedomfish')

print c1.between?(c2, c3)
print c2.between?(c3, c1)


# 選択肢
# XXXX

# include Comparable
# YYYY

# def <=> other
#   self.id <=> other.id
# end

# 選択肢
# XXXX

# extend Comparable
# YYYY

# def <=> other
#   other.id <=> self.id
# end

# 選択肢
# XXXX

# include Sortable
# YYYY

# def <=> other
#   self.id <=> other.id
# end

# 選択肢
# XXXX

# extend Sortable
# YYYY

# def <=> other
#   other.id <=> self.id
# end

# between?で値を比較するためには、Comparableをincludeする必要があります。

# Comparableは比較に<=>を使用しています。
# 自作クラスの場合はオブジェクトIDが比較対象となります。
# 通常は、Comparable#<=>をオーバーライドします。

# Fixnum#<=>(other)は以下の結果を返します。

# selfがotherより大きい場合は、1を返します。
# selfがotherと等しい場合は、0を返します。
# selfがotherより小さい場合は、-1を返します。
# extendはモジュールのインスタンスメソッドを特異メソッドとして追加します。
# インスタンス変数からメソッドを参照することができなくなるので、エラーになります。

# Sortableモジュールは存在しません。

46問 x 
class C
  def self._singleton
    class << C
      self
    end
  end
end

p C._singleton


選択肢
class C
  def self._singleton
    class << C
      val = self
    end
    val
  end
end

p C._singleton


選択肢
class C
end

def C._singleton
  self
end

p C._singleton


選択肢
class C
end

class << C
  def _singleton
    self
  end
end

p C._singleton


選択肢
class C
end
p C.singleton_class

# 47問 x 1 3

require 'json'

json = <<JSON
{
  "price":100,
  "order_code":200,
  "order_date":"2018/09/20",
  "tax":0.8
}
JSON

hash = __(1)__
p hash
期待値

{"price"=>100, "order_code"=>200, "order_date"=>"2018/09/20", "tax"=>0.8}

# 選択肢
# JSON.load json
# 選択肢
# JSON.save json
# 選択肢
# JSON.parse json
# 選択肢
# JSON.read json

# JSON形式の文字列をHashオブジェクトにするメソッドを選ぶ必要があります。

# JSON.loadまたは、JSON.parseは引数にJSON形式の文字列を指定するとHashオブジェクトに変換します。

require 'json'

json = <<JSON
{
  "price":100,
  "order_code":200,
  "order_date":"2018/09/20",
  "tax":0.8
}
JSON

using_parse = JSON.parse json
p using_parse

using_load = JSON.load json
p using_load
