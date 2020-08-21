# class Foo
#   def foo
#    puts "foo"
#   end
#  end
#  class Bar < Foo
#   def foo
#    puts "bar"
#   end
#  end
#  class Bar
#   undef_method :foo
#  end
#  Bar.new.foo


 class Foo
  def foo
   puts "foo"
  end
 end
 class Bar < Foo
  def foo
   puts "bar"
  end
 end
 class Bar
  remove_method :foo
 end
 Bar.new.foo
