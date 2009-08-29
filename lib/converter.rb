module Currency
  module Converter
    CURRENCIES = {
      'USD' => { :name => 'Dólar americano', :method => 'dollar', :prefix => 'US$ ', :decimal_delimiter => '.', :thousands_delimiter => ',' },
      'EUR' => { :name => 'Euro',            :method => 'euro',   :prefix => '€ ',   :decimal_delimiter => ',', :thousands_delimiter => '.' },
      'JPY' => { :name => 'Yen',             :method => 'yen',    :prefix => '¥ ',   :decimal_delimiter => ',', :thousands_delimiter => '.' },
      'GBP' => { :name => 'Libra esterlina', :method => 'libra',  :prefix => '£ ',   :decimal_delimiter => '.', :thousands_delimiter => ',' },
      'BRL' => { :name => 'Real',            :method => 'real',   :prefix => 'R$ ',  :decimal_delimiter => ',', :thousands_delimiter => '.' }
    }
    DEFAULT_CURRENCY = 'EUR'
    RATES_URL = 'http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml'

    def rates
      local_rates = { 'EUR' => 1.0 }
      doc.search('cube/cube/cube').each do |nodes|
        local_rates[nodes.attributes['currency']] = nodes.attributes['rate'].to_f
      end
      local_rates
    end

    CURRENCIES.each_pair do |key, value|
      define_method("to_#{value[:method]}") { eval "convert('#{key}')" }
    end

    private
      def doc
        date = Time.now.strftime("%Y-%m-%d")
        local_filename = "source/cotacao_#{date}.xml"
        if !File.exists?(local_filename)
          open(RATES_URL) { |content| File.open(local_filename, 'w') { |f| f.write(content.read) } }
        end
        Hpricot(open(local_filename))
      end

  end
end  
