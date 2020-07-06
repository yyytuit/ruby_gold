m = Module.new

CONST = "Constant in Toplevel" #このあたりもひっかけ

_proc = Proc.new do
  CONST = "Constant in Proc"  #このあたりもひっかけ
end

m.instance_eval(<<-EOS) # instance_eval で特異クラスにメソッドを定義する
  CONST = "Constant in Module instance"

  def const
    CONST
  end
EOS

# m.module_eval(<<-EOS) # module_eval のまま
#   CONST = "Constant in Module instance"

#   def const
#     CONST
#   end

#   module_function :const # module_function にシンボルでメソッドを指定する
# EOS

p m.module_eval(&_proc) #こちらの記述はただの引っ掛け

p m.const

