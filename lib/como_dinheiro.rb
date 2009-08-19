require 'lib/dinheiro'

module ComoDinheiro
  [['real', 'BRL'], ['dolar', 'USD'], ['euro', 'EUR'], ['yen', 'JPY']].each do |moeda|
    define_method(moeda[0]) { eval "Dinheiro.new(self, '#{moeda[1]}')" }
  end
  
  alias_method :dolares, :dolar
  alias_method :euros,   :euro 
  alias_method :reais,   :real
  alias_method :yens,    :yen
end

Numeric.send(:include, ComoDinheiro)
String.send(:include, ComoDinheiro)
