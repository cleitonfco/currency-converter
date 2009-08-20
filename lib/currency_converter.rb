$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
%w(bigdecimal rubygems hpricot open-uri).each { |lib| require lib }
%w(converter money act_as_money).each { |lib| require File.dirname(__FILE__) + "/#{lib}" }

Numeric.send :include, Numerical::Acts_As_Money
String.send :include, Numerical::Acts_As_Money
NilClass.send :include, Numerical::Acts_As_NilMoney
