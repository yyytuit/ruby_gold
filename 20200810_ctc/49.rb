class Bar
  def foo
   puts "barbarbar"
  end
 end
 class Foo < Bar
  def initialize(obj)
   obj.foo
  end
  def foo
   puts "foofoofoo"
  end
 end
 Foo.new(Foo.new(Bar.new))
