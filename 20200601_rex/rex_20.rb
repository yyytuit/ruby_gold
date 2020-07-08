# val = 100

# def method(val)
#   yield(15 + val)
# end

# _proc = Proc.new{|arg| val + arg }

# p method(val, &_proc.to_proc)



# val = 100

# def method(val)
#   yield(15 + val)
# end

# _proc = Proc.new{|arg| val + arg }

# p method(val, _proc.to_proc)


# val = 100

# def method(val)
#   yield(15 + val)
# end

# _proc = Proc.new{|arg| val + arg }

# p method(val, _proc)



# val = 100

# def method(val)
#   yield(15 + val)
# end

# _proc = Proc.new{|arg| val + arg }

# p method(val, &_proc)

#rocオブジェクトをメソッドで実行するにはブロックに変換する必要があります。
#&をProcオブジェクトのプレフィックスにすることでブロックに変換することが出来ます。

#また、to_procメソッドはProcオブジェクトを生成して返します。Procオブジェクトをレシーバにto_procを実行するとレシーバ自身が返ってきます。

#この問題の答えは、&_proc.to_procと&_procです。
