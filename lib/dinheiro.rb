require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'bigdecimal'

class Dinheiro

  attr_reader :quantia, :moeda_base

  CONFIGURACAO_MOEDAS = {
    'USD' => { :nome => 'dólar americano', :prefixo => 'US$ ',  :separador_decimal => '.', :separador_milhar => ',' },
    'EUR' => { :nome => 'euro',            :prefixo => '€ ',    :separador_decimal => ',', :separador_milhar => '.' },
    'JPY' => { :nome => 'yen',             :prefixo => '¥ ',    :separador_decimal => ',', :separador_milhar => '.' },
    'BRL' => { :nome => 'real',            :prefixo => 'R$ ',   :separador_decimal => ',', :separador_milhar => '.' }
  }
  URL_COTACOES = 'http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml'
  MOEDA_REFERENCIA = 'EUR'

  def initialize(quantia = 0, moeda_base = 'EUR')
    @quantia = BigDecimal.new(quantia.to_s)
    @moeda_base = moeda_base
    @@cotacoes = { 'EUR' => 1.0 }
    rates.search('cube/cube/cube').each do |nodes|
      @@cotacoes[nodes.attributes['currency']] = nodes.attributes['rate'].to_f
    end
  end

  def para(moeda_destino)
    return Dinheiro.new(@quantia * cotacoes[moeda_destino], moeda_destino) if @moeda_base == MOEDA_REFERENCIA
    if moeda_destino == MOEDA_REFERENCIA
      Dinheiro.new(@quantia / cotacoes[@moeda_base], moeda_destino)
    else
      Dinheiro.new(@quantia / cotacoes[@moeda_base] * cotacoes[moeda_destino], moeda_destino)
    end
  end

  def rates
    date = Time.now.strftime("%Y-%m-%d")
    local_filename = "source/cotacao_#{date}.xml"
    if !File.exists?(local_filename)
      open(URL_COTACOES) { |content| File.open(local_filename, 'w') { |f| f.write(content.read) } }
    end
    doc = Hpricot(open(local_filename))
  end

  def valor
    ("%.2f" % @quantia).to_f
  end

  def cotacoes
    @@cotacoes
  end

  [['real', 'BRL'], ['dolar', 'USD'], ['euro', 'EUR'], ['yen', 'JPY']].each do |moeda|
    define_method("to_#{moeda[0]}") { eval "para('#{moeda[1]}')" }
  end

  alias_method :to_dolares, :to_dolar
  alias_method :em_dolar,   :to_dolar
  alias_method :em_dolares, :to_dolar
  alias_method :to_reais,   :to_real
  alias_method :em_real,    :to_real
  alias_method :em_reais,   :to_real
  alias_method :to_euros,   :to_euro
  alias_method :em_euro,    :to_euro
  alias_method :em_euros,   :to_euro

  def formatado
    "#{CONFIGURACAO_MOEDAS[@moeda_base][:prefixo]}#{to_s}"
  end

  def to_s
    zeros = inteiro > 0 ? "0" * (3 - inteiro.to_s.length % 3) : "0" * (3 - inteiro.abs.to_s.length % 3)
    valor = inteiro.to_s.sub(/([+-]?)(\d+)/, '\1' + zeros + '\2').
                gsub(/(\d{3})/, CONFIGURACAO_MOEDAS[@moeda_base][:separador_milhar] + '\1').
                gsub(/^([+-]?)[.,0]*/, '\1')
    valor + CONFIGURACAO_MOEDAS[@moeda_base][:separador_decimal] + decimal
  end

  private
    def inteiro
      @quantia.to_i
    end
    
    def decimal
      ("%.2f" % @quantia).split(".")[1]
    end
end
