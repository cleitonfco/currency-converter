class Dinheiro

  MOEDAS = {
    "USD" => { :rate => 1.4101, :format => "US$" }, 
    "BRL" => { :rate => 2.6281, :format => "R$" }, 
    "EUR" => { :rate => 1, :format => "€" }
  }
  MOEDA_REFERENCIA = "EUR"
  attr_reader :valor, :moeda_base

  def initialize(valor = 0, moeda_base = "EUR")
    @valor = valor
    @moeda_base = moeda_base
  end

  def para(moeda_destino)
    return @valor * MOEDAS[moeda_destino][:rate] if @moeda_base == MOEDA_REFERENCIA
    if moeda_destino == MOEDA_REFERENCIA
      @valor / MOEDAS[moeda_destino][:rate]
    else
      @valor / MOEDAS[MOEDA_REFERENCIA][:rate] * MOEDAS[moeda_destino][:rate]
    end
  end

  def formatado
    "#{MOEDAS[@moeda_base][:format]} #{@valor.to_f}"
  end

  def to_s
    @valor.to_f.to_s
  end
end
