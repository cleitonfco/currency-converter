require File.dirname(__FILE__) + '/spec_helper'

class MoneySample
  include Currency::Converter

  def rate(code)
    d = (doc/"cube/cube/cube[@currency='#{code}']").attr('rate')
  end
end

describe Currency::Converter do
  it "'rates' deve carregar de um documento armazenado localmente" do
    date = Time.now.strftime("%Y-%m-%d")
    money = MoneySample.new
    rates = money.rates
    File.exists?("source/cotacao_#{date}.xml").should be_true
  end

  it "'rates' deve retornar um Hash com várias taxas de câmbio" do
    money = MoneySample.new
    money.rates.include?('BRL').should be_true
    money.rates.include?('USD').should be_true
    money.rates.include?('GBP').should be_true
    money.rates.include?('JPY').should be_true
  end

  it "'rates' deve retornar as taxas de câmbio de cada moeda" do
    money = MoneySample.new
    money.rates['BRL'].should == money.rate('BRL').to_f
    money.rates['USD'].should == money.rate('USD').to_f
    money.rates['GBP'].should == money.rate('GBP').to_f
    money.rates['JPY'].should == money.rate('JPY').to_f
  end
end
