require 'lib/como_dinheiro.rb'

describe ComoDinheiro do
  it "um número pode ser tratado como Dinheiro" do
    10.euro.valor.should == Dinheiro.new(10).valor
    10.real.valor.should == Dinheiro.new(10, 'BRL').valor
    10.yen.valor.should == Dinheiro.new(10, 'JPY').valor
    10.dolar.valor.should == Dinheiro.new(10, 'USD').valor
  end

  it "um Dinheiro deve ter a moeda correspondente" do
    10.euro.moeda_base.should == 'EUR'
    10.real.moeda_base.should == 'BRL'
    10.yen.moeda_base.should == 'JPY'
    10.dolar.moeda_base.should == 'USD'
  end

  it "um número pode ser tratado como Dinheiro através de chamadas alternativas" do
    10.euro.valor.should == 10.euros.valor
    10.real.valor.should == 10.reais.valor
    10.yen.valor.should == 10.yens.valor
    10.dolar.valor.should == 10.dolares.valor
  end
end
