letters = catch(:done) do
  ("a".."z").each do |a|
    ("a".."z").each do |b|
      ("a".."z").each do |c|
        if a < b && b < c
          __(1)__
        end
      end
    end
  end
end

puts letters.join

[期待される出力結果]
abc

# A: throw [a,b,c]

# B: throw [a,b,c], :done

# C: throw :done, [a,b,c]

# D: `raise :done, [a,b,c]

# 答え：C
# 解説
# 2つの引数形式の「throw」が使用される場合、2番目の引数は対応する「catch」呼び出しから返されます。
