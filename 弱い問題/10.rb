# 1
# def hoge(&block, *args)
#   block.call(*args)
# end

# hoge(1,2,3,4) do |*args|
#   p args.length > 0 ? "hello" : args
# end

# 4
# def hoge(*args, &block)
#   block.call(args)
# end

# hoge(1,2,3,4) do |*args|
#   p args.length < 0 ? "hello" : args
# end

# 2
# def hoge(*args, &block)
#   block.call(*args)
# end

# hoge(1,2,3,4) do |*args|
#   p args.length > 0 ? "hello" : args
# end

# 選択肢
# エラーが発生する

# 選択肢
# "hello"と表示される

# 選択肢
# 警告が表示される

# 選択肢
# [[1, 2, 3, 4]]と表示される

