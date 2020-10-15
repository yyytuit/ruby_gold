期待される出力結果となるように、(1)に入る選択肢を二つ選んでください

begin
  raise __(1)__
rescue
  puts "OK"
end

[Execution Result]
OK
 

A: raise StandardError

B: raise Exception

C: raise ArgumentError

D: `raise ScriptError

答え：A,C
解説
この質問にリストされている各クラスのチェーンは次のようになっています。

ArgumentError < StandardError < Exception

ScriptError < Exception

特定のエラークラスなしで rescueが呼び出されると、デフォルトでStandardErrorとその子孫をキャッチします。
コアRubyのほとんどの例外は StandardErrorの子孫ですが、Exceptionベースクラスから直接派生する他のクラス階層に存在する、通常は救助を意図していないものもあります。
