期待される出力結果となるように、(1)に入る選択肢を一つ選んでください

if __(1)__ == "Henry"
  puts "Hi Henry!!!"
else
  puts "Hello, stranger."
end

[期待される出力結果]
Hi Henry!!!


A: ENV['EMPLOYEE_NAME']

B: $env['EMPLOYEE_NAME']

C: ENV[:EMPLOYEE_NAME]

D: `$env[:EMPLOYEE_NAME]

答え：A
解説
環境変数は、変数名とその値の両方を文字列として表すハッシュのようなオブジェクトを参照する「ENV」定数を介してアクセスされます。
