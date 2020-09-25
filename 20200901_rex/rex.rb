# 問題3 x
class C
  @val = 3
  attr_accessor :val
  class << self
    @val = 10
  end
  def initialize
    @val *= 2 if val
  end
end

c = C.new
c.val += 10

p c.val

# 選択肢
# 13と表示される

# 選択肢
# 16と表示される

# 選択肢
# 20と表示される

# 選択肢
# エラーになる

# 問題のコードは、13行目でc.valがnilになり、実行エラーになります。

# 2行目の@valはクラスインスタンス変数といい、特異メソッドからアクセスすることができます。

# 3行目の@valは特異クラスのクラスインスタンス変数です。
# この値にアクセスするためには以下のようにアクセスします。

class << C
  p @val
end
# 13行目のc.valはattr_accessorよりアクセスされます。
# initializeメソッドで初期化が行われていないため、nilが返されます。

# 以下のコードは問題コードに行番号をつけています。

 class C
   @val = 3
   attr_accessor :val
   class << self
     @val = 10
   end
   def initialize
     @val *= 2 if val
   end
 end

 c = C.new
 c.val += 10

 p c.val

#  問題42 x 234
#  次のプログラムと同じ結果になる選択肢を選んでください。

 module M
   def self.a
     100
   end
 end
 p M.a

#  選択肢
#  module M
#    include self
#    def a
#      100
#    end
#  end
#  p M.a

#  選択肢
#  module M
#    extend self
#    def a
#      100
#    end
#  end
#  p M.a

#  選択肢
#  module M
#    def a
#      100
#    end
 
#    module_function :a
#  end
 
#  p M.a
#  選択肢
#  module M
#    class << self
#      def a
#        100
#      end
#    end
#  end
 
#  p M.a


# 問題45x 4
class C
  def self._singleton
    class << C
      self
    end
  end
end
p C._singleton

# 選択肢
# class C
#   def self._singleton
#     class << C
#       val = self
#     end
#     val
#   end
# end
# p C._singleton

# 選択肢
# class C
# end
# def C._singleton
#   self
# end
# p C._singleton

# 選択肢
# class C
# end
# class << C
#   def _singleton
#     self
#   end
# end
# p C._singleton

# 選択肢
# class C
# end
# p C.singleton_class
