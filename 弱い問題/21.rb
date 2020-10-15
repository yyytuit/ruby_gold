class Identity
  def self.this_object
    self.class
  end

  def this_object
    self
  end
end

p Identity.this_object.class
p Identity.new.this_object.class

A:

Identity
Identity
B:

Class
Identity
C:

Object
Identity
D:

Class
Object

# 答え：B
# 解説
# クラスメソッドでは、 selfはClassオブジェクトのインスタンスを指します。
# インスタンスメソッドでは、「self」は現在インスタンス化されているオブジェクトが何であるかを指します。
