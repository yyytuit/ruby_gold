10.times{|d| print d < 2...d > 5 ? "O" : "X" }

# 選択肢
# シンタックスエラーとなる

# 選択肢
# XXXXXXXXXX と表示される

# 選択肢
# OOXXXXOOOO と表示される

# 選択肢
# OOOOOOOXXX と表示される

# Integer#timesは0からself -1までの数値を順番にブロックに渡すメソッドです。

# d < 2...d > 5の部分は条件式に範囲式を記述しています。
# この式は、フリップフロップ回路のように一時的に真偽を保持するような挙動をとります。

# 詳細は、Rubyリファレンスに詳しい説明がありますのでそちらを参照してください。
