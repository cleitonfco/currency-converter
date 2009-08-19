require 'lib/dinheiro'

module ComoDinheiro

  Dinheiro::MOEDAS.each_pair do |key, value|
    define_method(value[:method]) { eval "Dinheiro.new(self, '#{key}')" }
  end
  
  alias_method :dolares, :dolar
  alias_method :euros,   :euro 
  alias_method :reais,   :real
  alias_method :yens,    :yen
end

module ComoDinheiroNil
  Dinheiro::MOEDAS.each_pair do |key, value|
    define_method(value[:method]) { eval "0.#{value[:method]}" }
  end

  alias_method :dolares, :dolar
  alias_method :euros,   :euro 
  alias_method :reais,   :real
  alias_method :yens,    :yen
end

Numeric.send(:include, ComoDinheiro)
String.send(:include, ComoDinheiro)
NilClass.send(:include, ComoDinheiroNil)
