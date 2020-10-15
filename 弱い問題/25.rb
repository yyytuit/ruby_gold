[コード1]
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
 undef_method :foo
end
Bar.new.foo


[コード2]
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
 1．	[コード1]
foo
[コード2]
bar
 2．	[コード1]
bar
[コード2]
foo
 3．	[コード1]
foo
[コード2]
エラーになる
 4．	[コード1]
エラーになる
[コード2]
foo

解答：４
解説
コード１でfooメソッドは未定義化されておりますのでメソッド呼び出し時にエラーになります。
コード2では、メソッドの未定義化にremove_methodを使用しておりますが、このメソッドはスーパークラスに同名のメソッドがある場合にそれが呼ばれるので、エラーになりません。

