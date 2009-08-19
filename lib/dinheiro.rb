class Dinheiro

  attr_reader :valor, :moeda_base
  CONFIGURACAO_MOEDAS = {
    'USD' => { :nome => 'dólar americano', :prefixo => '$ ',  :separador_decimal => '.', :separador_milhar => ',' },
    'EUR' => { :nome => 'euro',            :prefixo => '€ ',  :separador_decimal => ',', :separador_milhar => '.' },
    'BRL' => { :nome => 'real',            :prefixo => 'R$ ', :separador_decimal => ',', :separador_milhar => '.' }
  }
  COTACOES = {'USD' => 1.4101, 'BRL' => 2.6281, 'EUR' => 1 }
  MOEDA_REFERENCIA = 'EUR'

  def initialize(valor = 0, moeda_base = 'EUR')
    @valor = (valor * 100).to_i / 100.0
    @moeda_base = moeda_base
  end

  def para(moeda_destino)
    return @valor * COTACOES[moeda_destino] if @moeda_base == MOEDA_REFERENCIA
    if moeda_destino == MOEDA_REFERENCIA
      @valor / COTACOES[@moeda_base]
    else
      @valor / COTACOES[@moeda_base] * COTACOES[moeda_destino]
    end
  end

  def formatado
    "#{CONFIGURACAO_MOEDAS[@moeda_base][:prefixo]}#{to_s}"
  end

  def to_s
    separadores = (inteiro.to_s.length / 3.0).ceil - 1
    saldo = inteiro.to_s.length % 3
    re = '^([+-]?)'
    re << '(\d{' + saldo.to_s + '})' if saldo > 0
    re << '(\d{3})' * separadores
    re << '$'
    rex = Regexp.new(re)

#http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote;date=20090814;currency=true?view=basic&format=json
#    puts rex.source
#    puts CONFIGURACAO_MOEDAS[@moeda_base][:separador_decimal]
    valor = inteiro.to_s.gsub(rex, "#{$1}#{$2},#{$3}")
    valor + CONFIGURACAO_MOEDAS[@moeda_base][:separador_decimal] + decimal.to_s
#    valor = @valor.to_s.gsub(".", CONFIGURACAO_MOEDAS[:separador_decimal])
#    if /^([+-]?)(\d)$/ =~
#      return "#{$1}0#{CONFIGURACAO_MOEDAS[:separador_decimal]}0#{$2}"
#    end
#    /^([+-]?)(\d*)(\d\d)$/ =~ quantia.to_s
#    "#{$1}#{$2.to_i}.#{$3}"
#    return inteiro if quantidade_de_passos(inteiro) == 0
#    resultado = ""
#    quantidade_de_passos(inteiro).times do |passo|
#      resultado = "." + inteiro[-QUANTIDADE_DIGITOS + passo * -QUANTIDADE_DIGITOS, QUANTIDADE_DIGITOS] + resultado
#    end
#    resultado = inteiro[0, digitos_que_sobraram(inteiro)] + resultado
#    resultado.gsub(/^(-?)\./, '\1')
  end

  private
    def inteiro
      @valor.to_i
    end
    
    def decimal
      ((@valor - inteiro) * 100).to_i
    end
end
