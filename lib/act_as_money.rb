module Numerical
  module Acts_As_Money

    Money::CURRENCIES.each_pair do |key, value|
      define_method(value[:method]) { eval "Money.new(self, '#{key}')" }
    end

  end

  module Acts_As_NilMoney

    Money::CURRENCIES.each_pair do |key, value|
      define_method(value[:method]) { eval "0.#{value[:method]}" }
    end

  end

end
