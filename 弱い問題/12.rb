# 25問 4
# 次のコードを実行するとどうなりますか

def foo(n)
  n ** n
end

foo = Proc.new { |n|
  n * 3
}

puts foo[2] * 2


# 選択肢
# 8と表示される

# 選択肢
# 256と表示される

# 選択肢
# 16777216と表示される

# 選択肢
# 12と表示される

# メソッドと変数の探索順位は変数が先です。

# Procはcallまたは[]で呼び出すことができます。

# 問題では、foo[2]と宣言されているため、探索順の早いProcオブジェクトが呼び出されます。
# もし、foo 2と宣言された場合は、メソッドが選択されます。

# 33問 x 124
実行してもエラーにならないコードを選べ

# 選択肢
def bar(&block)
  block.yield
end

bar do
  puts "hello, world"
end


# 選択肢
def bar(&block)
  block.call
end

bar do
  puts "hello, world"
end


# 選択肢
def bar(&block, n)
  block.call
end

bar(5) {
  puts "hello, world"
}



# 選択肢
def bar(n, &block)
  block.call
end

bar(5) {
  puts "hello, world"
}

# 引数名に&を付与することでブロック引数になります。
# ブロック引数は他の引数より後に記述します。
