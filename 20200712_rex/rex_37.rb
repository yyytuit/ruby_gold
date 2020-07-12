require 'singleton'

class Message
  include Singleton

  def morning
    'Hi, good morning!'
  end
end
p Message.instance.morning
