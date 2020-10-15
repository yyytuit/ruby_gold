class BaseClass
  private

  def greet
    puts "Hello World!"
  end
end

class ChildClass < BaseClass
  __(1)__
end


ChildClass.new.greet

[期待される出力]
Hello World!


A:

public :greet
B:

protected :greet
C:

def greet
  super
end
D:

alias_method :original_greet, :greet

def greet
  original_greet
end

# 答え：B
# 解説
# protectedメソッドは、同じクラスまたはその子孫のインスタンス内からのみ呼び出すことができます。
