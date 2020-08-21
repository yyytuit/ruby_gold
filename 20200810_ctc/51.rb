class Foo
  private
  def foo
   puts "foofoofoo"
  end
 end
 puts Foo.new.respond_to?(:foo)
