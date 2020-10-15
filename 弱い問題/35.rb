
期待される出力結果となるように、(1)に入る選択肢を２つ選んでください

__(1)__

p multiply_by(4) { 2 + 3 }

[Execution Result]
20
 

A:

def multiply_by(n, &block)
  n * block.call
end
B:

def multiply_by(n, &block)
  n * block
end
C:

def multiply_by(n)
  n * yield
end
D:

def multiply_by(n)
  n * yield.call
end

答え：A,C
解説
メソッドシグネチャで明示的に指定されているかどうかにかかわらず、Rubyのすべてのメソッドはブロックを受け入れることができます。
`yield`キーワードは、ブロックを暗黙的に呼び出すために使用されます。
`＆block`構文は、ブロックを` Proc`オブジェクトに変換するために使用されます。
これは、 `call（）`を介して呼び出すか、他のメソッドに渡すことができます。
