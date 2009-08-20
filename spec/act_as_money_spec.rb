require File.dirname(__FILE__) + '/spec_helper'

describe Numeric do
  it "can acts as Money" do
    10.euro.value.should == Money.new(10).value
    10.real.value.should == Money.new(10, 'BRL').value
    10.yen.value.should == Money.new(10, 'JPY').value
    10.dollar.value.should == Money.new(10, 'USD').value
  end

  it "as Money should have a currency code" do
    10.euro.currency_base.should == 'EUR'
    10.real.currency_base.should == 'BRL'
    10.yen.currency_base.should == 'JPY'
    10.dollar.currency_base.should == 'USD'
  end
end

describe String do
  it "numeric can acts as Money" do
    "10".euro.value.should == Money.new(10).value
    "10.5".real.value.should == Money.new(10.5, 'BRL').value
    "10.0".yen.value.should == Money.new(10, 'JPY').value
    "0".dollar.value.should == Money.new(0, 'USD').value
  end

  it "as Money should have a currency code" do
    "10".euro.currency_base.should == 'EUR'
    "10.5".real.currency_base.should == 'BRL'
    "10.0".yen.currency_base.should == 'JPY'
    "0".dollar.currency_base.should == 'USD'
  end
end

describe NilClass do
  it "can acts as Money..." do
    nil.euro.currency_base.should == 'EUR'
    nil.real.currency_base.should == 'BRL'
  end

  it "... but your value is zero" do
    nil.euro.value.should == 0.0
    nil.real.value.should == 0.0
  end
end
