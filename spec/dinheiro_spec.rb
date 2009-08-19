require 'lib/dinheiro.rb'

describe Dinheiro do
  before(:each) do
    @cotacao = Dinheiro::MOEDAS
  end

  describe "em Real" do
    before(:each) do
      valor = rand(500) / 100
      @dinheiro = Dinheiro.new(valor, 'BRL')
    end

    it "convertendo para Euro" do
      @dinheiro.para('EUR').should == @dinheiro.valor * @cotacao['EUR'][:rate]
    end

    it "convertendo para Dólar" do
      @dinheiro.para('USD').should == @dinheiro.valor / @cotacao['EUR'][:rate] * @cotacao['USD'][:rate]
    end

    it "formatado deve retornar o símbolo da moeda" do
      @dinheiro.formatado.should == "R$ #{@dinheiro.valor.to_f}"
    end

    it "formatado deve retornar o símbolo da moeda ----" do
      @dinheiro.to_s.should == @dinheiro.valor.to_f.to_s
    end
  end

  describe "em Dólar" do
    before(:each) do
      valor = rand(500) / 100
      @dinheiro = Dinheiro.new(valor, 'USD')
    end

    it "convertendo para Euro" do
      @dinheiro.para('EUR').should == @dinheiro.valor * @cotacao['EUR'][:rate]
    end

    it "convertendo para Real" do
      @dinheiro.para('BRL').should == @dinheiro.valor / @cotacao['EUR'][:rate] * @cotacao['BRL'][:rate]
    end

    it "formatado deve retornar o símbolo da moeda" do
      @dinheiro.formatado.should == "US$ #{@dinheiro.valor.to_f}"
    end
  end

end
