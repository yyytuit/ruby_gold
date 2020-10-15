AnError = Class.new(Exception)

begin
  raise AnError
rescue
  puts "Bare rescue"
rescue StandardError
  puts "StandardError rescue"
rescue Exception
  puts "Exception rescue"
rescue AnError
  puts "AnError rescue"
end

A:

Bare rescue
B:

StandardError rescue
C:

AnError rescue
D:

Exception rescue
E:

Exception rescue
AnError rescue

# 答え：D

# 解説
# rescue Exceptionとrescue AnErrorは両方とも発生した例外に一致しますが、この例では rescue Exception節がキャッチされ、rescue AnErrorは無視されます
