class ScrapperFactory
  def self.get_scrapper(url)
    CurseScrapper.new # no other scrappers currently
  end
end
