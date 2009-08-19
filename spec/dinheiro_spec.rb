require 'lib/dinheiro.rb'

describe Dinheiro do
  before(:each) do
    @valor_original = 8177.8995
    @valor_moeda = (@valor_original * 100).to_i / 100.0
  end

  describe "em Real" do
    before(:each) do
      @dinheiro = Dinheiro.new(@valor_original, 'BRL')
      @dinheiro.stub!(:cotacoes).and_return({ 'USD' => 1.4101, 'BRL' => 2.6281, 'EUR' => 1 })
    end

    it "convertendo para Euro" do
      @dinheiro.para('EUR').valor.should == 3111.72
    end

    it "convertendo para Dólar" do
      @dinheiro.para('USD').valor.should == 4387.83
    end

    it "formatado deve retornar o formato correto da moeda" do
      @dinheiro.formatado.should == "R$ 8.177,90"
    end

    it "to_s deve estar de acordo com o padrão da moeda" do
      Dinheiro.new(0, 'BRL').to_s.should == "0,00"
      Dinheiro.new(1234567.89, "BRL").to_s.should == "1.234.567,89"
      Dinheiro.new(-15935.7416, "BRL").to_s.should == "-15.935,74"
      Dinheiro.new('987654.321', "BRL").to_s.should == "987.654,32"
      Dinheiro.new(1478523698741236951, "BRL").to_s.should == "1.478.523.698.741.236.951,00"
    end
  end

  describe "em Dólar" do
    before(:each) do
      @dinheiro = Dinheiro.new(@valor_original, 'USD')
      @dinheiro.stub!(:cotacoes).and_return({ 'USD' => 1.4101, 'BRL' => 2.6281, 'EUR' => 1 })
    end

    it "convertendo para Euro" do
      @dinheiro.para('EUR').valor.should == 5799.52
    end

    it "convertendo para Real" do
      @dinheiro.para('BRL').valor.should == 15241.71
    end

    it "formatado deve retornar o formato correto da moeda" do
      @dinheiro.formatado.should == "US$ 8,177.90"
    end

    it "to_s deve estar de acordo com o padrão da moeda" do
      Dinheiro.new(0, 'USD').to_s.should == "0.00"
      Dinheiro.new(1234567.89, "USD").to_s.should == "1,234,567.89"
      Dinheiro.new(-15935.7416, "USD").to_s.should == "-15,935.74"
      Dinheiro.new(987654.321, "USD").to_s.should == "987,654.32"
      Dinheiro.new('1478523698741236951', "USD").to_s.should == "1,478,523,698,741,236,951.00"
    end
  end

  describe "em Euro" do
    before(:each) do
      @dinheiro = Dinheiro.new(@valor_original, 'EUR')
      @dinheiro.stub!(:cotacoes).and_return({ 'USD' => 1.4101, 'BRL' => 2.6281, 'EUR' => 1 })
    end

    it "convertendo para Real" do
      @dinheiro.para('BRL').valor.should == 21492.34
    end

    it "convertendo para Dólar" do
      @dinheiro.para('USD').valor.should == 11531.66
    end

    it "formatado deve retornar o formato correto da moeda" do
      @dinheiro.formatado.should == "€ 8.177,90"
    end

    it "to_s deve estar de acordo com o padrão da moeda" do
      Dinheiro.new.to_s.should == "0,00"
    end
  end
end
