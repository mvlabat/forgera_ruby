require 'concurrent/synchronization'

class ModService
  def create_mod(project_url)
    scrapper = ScrapperFactory.get_scrapper(project_url)
    mod = merge_result(Mod.new(project_url: project_url), scrapper.scrap(project_url))
    mod.save
    Concurrent::Maybe.just(mod)
  rescue StandardError => e
    puts "#{e.class}: #{e.message}"
    Concurrent::Maybe.nothing(e)
  end

  def retrieve_mods_updated
    def scrap_wrapped(project_url)
      scrapper = ScrapperFactory.get_scrapper(project_url)
      Concurrent::Maybe.just(scrapper.scrap(project_url))
    rescue StandardError => e
      puts "#{e.class}: #{e.message}"
      Concurrent::Maybe.nothing(e)
    end

    updated_mods = Mod.all.map do |mod|
      url = mod.project_url
      maybe = scrap_wrapped(url)
      if maybe.just?
        merge_result(mod, maybe.just)
      else
        mod
      end
    end

    Mod.transaction do
      updated_mods.each(&:save)
    end

    updated_mods
  end

  private

  def merge_result(actual, new)
    copy = actual.clone
    copy.name = new.name
    copy.version = new.version
    copy
  end

end
