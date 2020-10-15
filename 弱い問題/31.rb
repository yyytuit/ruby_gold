# 以下のコードを実行したらどうなりますか。テストされるクラスファイルfoo.rbは存在していると仮定します。
require 'test/unit' 
require 'foo' 
class TC_Foo < Test::Unit::TestCase
 def foo_test
   #テストコード
 end
end
1.foo_testが規約に則っていないので実行されない。
2.test/unitの記述が誤りのため、例外が発生する。
3.Test::Unit::TestCaseの記述が誤りのため、例外が発生する。
4.テストが実行される。

答え　1
Test::Unitのテストメソッド名はtest_で始めます。
