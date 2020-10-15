次のコードの実行結果を選択してください。

CustomError = Class.new(StandardError)

def boom
  raise CustomError 
rescue
  raise
end

begin 
  boom
rescue => e
  p e.class
end

A: CustomError

B: StandardError

C: Exception

D: RuntimeError

E: `SyntaxError

答え：A
解説
例外タイプを指定せずに「rescue」ブロック内で「raise」が呼び出された場合、発生した例外タイプはレスキューされた例外と一致します。

「raise」が呼び出され、現在のコンテキストでレスキューされた例外がない場合、デフォルトで「RuntimeError」が発生します。
