def x
  puts "x"
end

def y
  puts "y"
  throw :done
end

def z
  puts "z"
end


__(1)__ do
  x
  y
  z
end

puts "done!"

[Execution Result]
x
y
done!

# A: try

# B: catch

# C: catch :done

# D: `rescue

# 答え：C

# 解説
# 「catch」ブロック内では、「throw」ステートメントが実行されるまで、コードは通常どおり実行されます。
# 次に、「throw」を介して渡されたシンボルが「catch」シンボルと一致する場合、Rubyはブロックを終了し、それに続くものはすべて実行し続けます。

# 「catch」ブロックが「throw」と一致しない場合、Rubyは、スローされたシンボルに一致するか、
# キャッチされないトップレベルに到達するブロックを見つけるまで、ネストされた「catch」ブロックを裏返しに続けます。 例外が発生します。
