class Money
  include Currency::Converter

  attr_reader :amount, :currency_base

  def initialize(amount = 0, currency = 'EUR')
    @amount = BigDecimal.new(amount.to_s)
    @currency_base = currency
  end

  def convert(to_currency)
    return Money.new(@amount * rates[to_currency], to_currency) if @currency_base == DEFAULT_CURRENCY
    if to_currency == DEFAULT_CURRENCY
      Money.new(@amount / rates[@currency_base], to_currency)
    else
      Money.new(@amount / rates[@currency_base] * rates[to_currency], to_currency)
    end
  end

  def value
    ("%.2f" % @amount).to_f
  end

  def formated
    "#{CURRENCIES[@currency_base][:prefix]}#{to_s}"
  end

  def to_s
    return "0#{CURRENCIES[@currency_base][:decimal_delimiter]}00" if @amount.zero?
    digits_length = complete_part > 0 ? complete_part.to_s.length : complete_part.abs.to_s.length
    zeros = "0" * (3 - digits_length % 3)
    result = complete_part.to_s.sub(/([+-]?)(\d+)/, '\1' + zeros + '\2').
                gsub(/(\d{3})/, CURRENCIES[@currency_base][:thousands_delimiter] + '\1').
                gsub(/^([+-]?)[.,0]*/, '\1')
    result + CURRENCIES[@currency_base][:decimal_delimiter] + decimal
  end

  private
    def complete_part
      @amount.to_i
    end
    
    def decimal
      ("%.2f" % @amount).split(".")[1]
    end
end
