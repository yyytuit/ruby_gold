class Speaker
  @message = "Hello!"

  class << self
    @message = "Howdy!"

    def speak
      @message
    end
  end
end

__(1)__

[期待される実行結果]
Hello!


A: puts Speaker.speak

B: puts Speaker.singleton_class.speak

C: puts Speaker.instance_variable_get(:@message)

D: puts Speaker.singleton_class.instance_variable_get(:@message)

# クラスはRubyのオブジェクトであるため、クラスインスタンス変数を定義できます。

# また、Rubyのすべてのオブジェクトには、クラスオブジェクトを含むシングルトンクラスが関連付けられています。

# この例では、「Speaker」クラスと「Speaker」のシングルトンクラスに「@message」という名前のインスタンス変数があります。

# シングルトンメソッド「Speaker.speak」は「Speaker」クラスのコンテキストで評価されるため、
# 「@ message」は「Speaker」クラス定義内で定義されたインスタンス変数を参照し、シングルトンクラス内で定義されたインスタンス変数は参照しません。
