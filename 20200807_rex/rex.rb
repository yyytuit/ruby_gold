# 12問 x 2
def m1(*)
  str = yield if block_given?
  p "m1 #{str}"
end

def m2(*)
  str = yield if block_given?
  p "m2 #{str}"
end

m1 m2 do
  "hello"
end


# 選択肢
# "m2 hello"
# "m1 "
# と表示される

# 選択肢
# "m2 "
# "m1 hello"
# と表示される

# 選択肢
# "m2 "
# "m1 "
# と表示される

# 選択肢
# 警告が表示される

# 問題のコードで使用されているメソッド類は以下の通りです。

# Kernel#block_given?はブロックが渡された場合は、真になります。
# yieldはブロックの内容を評価します。
# { }はdo endよりも結合度が高い為、実行結果に差が出ます。
# 問題のコードは以下のように解釈されます。

# m1の引数と解釈されるため、m2の戻り値はm2が表示されます。
# m1へdo .. endのブロックが渡されます。よって、m1 helloが表示されます。
# m1(m2) do
#   "hello"
# end

# # 実行結果
# # "m2 "
# # "m1 hello"
# 問題のコードをdo ... endで置き換えた場合は以下の実行結果になります。

# m1 m2 {  # m1 (m2 { .. } ) と解釈される
#   "hello"
# }

# # 実行結果
# # m2 hello
# # m1

