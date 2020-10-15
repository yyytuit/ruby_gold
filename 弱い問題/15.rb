[期待される出力]
[["apple", "banana", "carrot"]]
A:

def fx(*args)
  p(args)
end
fx(*["apple", "banana", "carrot"])
B:

def fx(*args)
  p(args)
end
fx(["apple", "banana", "carrot"])
C:

def fx(*args)
  p(args)
end
fx("apple", "banana", "carrot")
D:

def fx(*args)
  p(*args)
end
fx(["apple", "banana", "carrot"])


# 答え：B
# 解説
# splat演算子（ *）をメソッドパラメーターと共に使用すると、残りのすべての引数が配列にラップされ、
# この1つのパラメーターによって参照されるようになります。
# 上記の回答（B）では、 fx（* args）メソッドは0個以上の引数を受け入れ、それらすべてを args配列内に配置します。
# したがって、 fx（[ apple 、 banana 、 carrot ]）が呼び出されると、単一の引数（配列）が別の配列内に配置されるため、argsは[[appleを参照します。 「banana」、「calot」]]
