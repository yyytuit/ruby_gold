require 'date'
d1 = DateTime.new 
d2 = DateTime.new
p(d2-d1).class
1.Float
2.Rational
3.Fixnum
4.Bignum

答え 2
DateTime同士の減算はRationalインスタンスとなります。

