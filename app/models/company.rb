class Company < ActiveRecord::Base
  require 'open-uri'
  
  has_many  :reviews, :dependent => :destroy
  
  validates_presence_of   :name, :on => :create, :message => "can't be blank"
  
  def self.suggest(q)
    q = CGI::escape(q)
    doc = Hpricot(open("http://finance.google.com/finance/match?matchtype=matchall&q=#{q}&hl=en&gl=us"))
    JSON.parse(doc.to_s)['matches'].map do |suggestion|
      suggestion['n'].gsub('x27',"'").gsub('x26','&')
    end.uniq
  end
  
  def self.lookup_by_name(q)
    q = CGI::escape(q)
    doc = Hpricot(open("http://finance.google.com/finance?q=#{q}"))
    self.parse_google_finance(doc)
  end
  
  def self.lookup_by_google_cid(cid)
    doc = Hpricot(open("http://finance.google.com/finance?cid=#{cid}"))
    self.parse_google_finance(doc)
  end
  
  def self.get_logo_url(stock_symbol)
    exchange = stock_symbol.split(":")[0]
    ticker = stock_symbol.split(":")[1]
    case exchange
    when "NYSE"
      "http://www.nyse.com/images/listed/log-#{ticker.downcase}.gif"
    when "NASDAQ"
      "http://content.nasdaq.com/logos/#{ticker.downcase}.gif"
    when "AMEX"
      "http://www.amex.com/images/logo_#{ticker.downcase}.gif"
    else
      ""
    end
  end
  
  def self.get_logo(stock_symbol)
    exchange = stock_symbol.split(":")[0]
    ticker = stock_symbol.split(":")[1]
    case exchange
    when "NYSE"
      open("http://www.nyse.com/images/listed/log-#{ticker.downcase}.gif").inject("") do |file, block|
        file = file + block
      end
    when "NASDAQ"
      open("http://content.nasdaq.com/logos/#{ticker.downcase}.gif").inject("") do |file, block|
        file = file + block
      end
    when "AMEX"
      open("http://www.amex.com/images/logo_#{ticker.downcase}.gif").inject("") do |file, block|
        file = file + block
      end
    else
      ""
    end
  end
  
  private
  def self.parse_google_finance(doc)
    company_header = doc.search("#companyheader")
    summary = doc.search("#summary")
    # Parse Google Finance Page and return a new Company object
    Company.new do |c|
      c.name = company_header.search("h1").inner_html
      c.stock_symbol = company_header.to_s.match(/\(Public, .+\)/).to_s.match(/[A-Z]+:[A-Z]+/).to_s
      c.description = summary.search(".companySummary").inner_html.gsub(/<a\b[^>]*>.*?<\/a>/,'').gsub(146.chr,"'").gsub(176.chr,"").strip
      c.logo_url = get_logo_url(c.stock_symbol)
      c.website_url = summary.search("#fs-chome").inner_html.strip
      c.google_cid = company_header.to_s.match(/<a.*cid=(\d+)[^>]*>Discuss.*<\/a>/)[1]
    end
  end
  
end


