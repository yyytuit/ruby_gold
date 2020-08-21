class Foo
  def bar
    self.foo
  end
  private
  def foo
    puts "foo"
  end
end
Foo.new.bar
