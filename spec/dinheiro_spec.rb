require 'lib/dinheiro.rb'

describe Dinheiro do
  before(:each) do
    @cotacao = Dinheiro::COTACOES
    @valor_original = 8177.8995
    @valor_moeda = (@valor_original * 100).to_i / 100.0
  end

  describe "em Real" do
    before(:each) do
      @dinheiro = Dinheiro.new(@valor_original, 'BRL')
    end

    it "convertendo para Euro" do
      @dinheiro.para('EUR').should == @valor_moeda / @cotacao['BRL']
    end

    it "convertendo para Dólar" do
      @dinheiro.para('USD').should == @valor_moeda / @cotacao['BRL'] * @cotacao['USD']
    end

    it "formatado deve retornar o formato correto da moeda" do
      @dinheiro.formatado.should == "R$ 8.177,89"
    end

    it "to_s deve estar de acordo com o padrão da moeda" do
      @dinheiro.to_s.should == "8.177,89"
    end
  end

  describe "em Dólar" do
    before(:each) do
      @dinheiro = Dinheiro.new(@valor_original, 'USD')
    end

    it "convertendo para Euro" do
      @dinheiro.para('EUR').should == @valor_moeda / @cotacao['USD']
    end

    it "convertendo para Real" do
      @dinheiro.para('BRL').should == @valor_moeda / @cotacao['USD'] * @cotacao['BRL']
    end

    it "formatado deve retornar o formato correto da moeda" do
      @dinheiro.formatado.should == "$ 8,177.89"
    end
  end

  describe "em Euro" do
    before(:each) do
      @dinheiro = Dinheiro.new(@valor_original, 'EUR')
    end

    it "convertendo para Real" do
      @dinheiro.para('BRL').should == @valor_moeda * @cotacao['BRL']
    end

    it "convertendo para Dólar" do
      @dinheiro.para('USD').should == @valor_moeda * @cotacao['USD']
    end

    it "formatado deve retornar o formato correto da moeda" do
      @dinheiro.formatado.should == "€ 8.177,89"
    end
  end
end
