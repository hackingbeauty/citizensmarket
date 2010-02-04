module  CompanyLookup
  require 'open-uri'

  def self.suggest(q)
    q = CGI::escape(q)
    doc = Hpricot(open("http://finance.google.com/finance/match?matchtype=matchall&q=#{q}&hl=en&gl=us"))
    JSON.parse(doc.to_s)['matches'].map do |suggestion|
      suggestion['n'].gsub('x27',"'").gsub('x26','&')
    end.uniq
  end

  def self.by_name(q)
    q = CGI::escape(q)
    doc = Hpricot(open("http://finance.google.com/finance?q=#{q}"))
    self.make_company(doc)
  end

  def self.by_google_cid(cid)
    doc = Hpricot(open("http://finance.google.com/finance?cid=#{cid}"))
    self.make_company(doc)
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

    def self.make_company(doc)
      c = self.parse_google_finance(doc)
      c.description = self.get_wikipedia_description(c.name)
      c
    end

    def self.parse_google_finance(doc)
      company_header = doc.search(".company-header")
      summary = doc.search("#summary")
      # Parse Google Finance Page and return a new Company object
      Company.new do |c|
        c.name = company_header.search("h1").inner_html
        c.stock_symbol = company_header.to_s.match(/\(Public, .+\)/).to_s.match(/[A-Z]+:[A-Z]+/).to_s

        c.logo_url = get_logo_url(c.stock_symbol)
        c.website_url = summary.search("#fs-chome").inner_html.strip
        c.google_cid = doc.search("#groups").to_s.match(/<a.*cid=(\d+)[^>]*>More discussions.*<\/a>/)[1]
      end
    end

    def self.get_wikipedia_description(name)
      url_name = name.gsub(' ', '_').gsub(/[\.,]+/, '')
      doc = Hpricot(open("http://en.wikipedia.org/wiki/#{url_name}"))

      raw_description = doc.search('#bodyContent').search("//p")[0].to_s

      self.clean_up_wikipedia_description(raw_description)
    end

    def self.clean_up_wikipedia_description(raw_description)
      output = raw_description.gsub(/<a[^>]*>/, '') # remove <a> tags while preserving their inner html
      output = output.gsub(/<\/a>/, '')
      output = output.gsub(/<sup .*(?=<\/sup>)<\/sup>/m, '') # this is link-to-outside, like [1], [2] etc
      output = output.gsub('<p>', '').gsub('</p>', '') # grab only the <p>'s inner html
      output
    end

end
