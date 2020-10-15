以下の実行結果にならないようにするために__(1)__に当てはまるものを選択してください。
[コード]
 class Foo
   def bar(obj=nil)
    __(1)__
  end
  protected
  def foo
    puts "foo"
  end
 end
 Foo.new.bar(Foo.new)


[実行結果]
 foo
	1．	foo
	2．	Foo.foo
	3．	self.foo
	4．	obj.foo
問10の解答と解説
解答：２
解説
protected以降で定義されたメソッドは、そのクラスとサブクラスのインスタンスから呼び出すことができます。
しかし、クラスをレシーバとして呼び出すことはできませんので、「Foo.foo」ではエラーになります。
