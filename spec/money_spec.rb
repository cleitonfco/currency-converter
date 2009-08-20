require File.dirname(__FILE__) + '/spec_helper'

describe Money do
  before(:each) do
    @value = 123456789.87654321
    @rates = { 'USD' => 1.4101, 'BRL' => 2.6281, 'GBR' => 0.85660, 'JPY' => 134.12, 'EUR' => 1 }
  end

  describe "as Brazilian Real" do
    before(:each) do
      @money = Money.new(@value, 'BRL')
      @money.stub!(:rates).and_return(@rates)
    end

    it "converting to Euro" do
      @money.convert('EUR').value.should == 46975682
    end

    it "converting to American Dollar" do
      @money.convert('USD').value.should == 66240409.19
    end

    it "formated should return right currency format" do
      @money.formated.should == "R$ 123.456.789,88"
    end

    it "to_s should be currency format equivalent" do
      Money.new(0, 'BRL').to_s.should == "0,00"
      Money.new(1234567.89, "BRL").to_s.should == "1.234.567,89"
      Money.new(-15935.7416, "BRL").to_s.should == "-15.935,74"
      Money.new('987654.321', "BRL").to_s.should == "987.654,32"
      Money.new(1478523698741236951, "BRL").to_s.should == "1.478.523.698.741.236.951,00"
    end
  end

  describe "as American Dollar" do
    before(:each) do
      @money = Money.new(@value, 'USD')
      @money.stub!(:rates).and_return(@rates)
    end

    it "converting to Euro" do
      @money.convert('EUR').value.should == 87551797.66
    end

    it "converting to Real" do
      @money.convert('BRL').value.should == 230094879.42
    end

    it "formated should return right currency format" do
      @money.formated.should == "US$ 123,456,789.88"
    end

    it "to_s should be currency format equivalent" do
      Money.new(0, 'USD').to_s.should == "0.00"
      Money.new(1234567.89, "USD").to_s.should == "1,234,567.89"
      Money.new(-15935.7416, "USD").to_s.should == "-15,935.74"
      Money.new(987654.321, "USD").to_s.should == "987,654.32"
      Money.new('1478523698741236951', "USD").to_s.should == "1,478,523,698,741,236,951.00"
    end
  end

  describe "em Euro" do
    before(:each) do
      @money = Money.new(@value, 'EUR')
      @money.stub!(:rates).and_return(@rates)
    end

    it "convertendo para Real" do
      @money.convert('BRL').value.should == 324456789.47
    end

    it "convertendo para Dólar" do
      @money.convert('USD').value.should == 174086419.40
    end

    it "formated should return right currency format" do
      @money.formated.should == "€ 123.456.789,88"
    end

    it "to_s should be currency format equivalent" do
      Money.new.to_s.should == "0,00"
    end
  end
end
