class Foo
  def bar(obj=nil)
    obj.foo
  end
 protected
  def foo
    puts "foo"
  end
end
Foo.new.bar(Foo.new)
