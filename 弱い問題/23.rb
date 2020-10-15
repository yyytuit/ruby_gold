class Upcaser
  def initialize(value)
    @value = value
  end

  def +(other)
    self.class.new(@value + other.value)
  end

  def to_s
    @value.upcase
  end

  attr_reader :value
  __(1)__
end

puts Upcaser.new("Hello") + Upcaser.new("World")

[期待される出力結果]
HELLOWORLD


A: private :value

B: public :value

C: protected :value

D: static :value**

# 答え：B,C

# 解説
# -プライベートメソッドは、同じクラスのインスタンスであっても、別のオブジェクトから直接呼び出すことはできません。 -Rubyには`static`キーワードはありません。
