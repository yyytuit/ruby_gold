# 問題 x 1
module M
  def class_m
    "class_m"
  end
end

class C
  extend M
end

p C.methods.include? :class_m


# 選択肢
# trueが表示される

# 選択肢
# falseが表示される

# 選択肢
# nilが表示される

# 選択肢
# 警告が表示される

# extendは引数に指定したモジュールのメソッドを特異メソッドとして追加します。

# 問題のC.methods...は特異メソッドの一覧を取得します。


# 問題 x 1
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


# 問題 x 4
# 次のプログラムと同じく特異クラスを取得する選択肢を選んでください。

class C
  def self._singleton
    class << C
      self
    end
  end
end

p C._singleton


# 選択肢
class C
  def self._singleton
    class << C
      val = self
    end
    val
  end
end

p C._singleton


# 選択肢
class C
end

def C._singleton
  self
end

p C._singleton


# 選択肢
class C
end

class << C
  def _singleton
    self
  end
end

p C._singleton



# 選択肢
class C
end
p C.singleton_class

# Object.singleton_classを利用すると特異クラスを取得することが出来ます。

# 特異クラスでselfを参照するとレシーバのオブジェクトがとれます。この選択肢では、クラスCが取得できます。

# また、特異クラス定義では新しくスコープが作られますので次のプログラムでは例外が発生します。
