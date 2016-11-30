require 'mechanize'
require 'concurrent/synchronization'

class CurseScrapper
  include Concurrent

  def scrap(url)
    mod = Mod.new(project_url: url)

    mechanize = Mechanize.new
    page = mechanize.get(url + (url[-1] == '/' ? 'files' : '/files'))

    node = get_node(page)
    return Maybe.nothing if node.nothing?

    mod.name = get_mod_name(page)
    mod.version = extract_mod_version(mod.name, get_jar_filename(node.just))
    Maybe.just(mod)
  end

  protected

  def get_node(page)
    node_set = page.css('.listing-project-file tr.project-file-list-item')
    node_set.each do |subnode|
      return Maybe.just(subnode) if has_version(subnode, Mod.minecraft_version)
    end
    Maybe.nothing
  end

  def has_version(node, version)
    node.at_css('.version-label').content == version
  end

  def get_jar_filename(node)
    node.at_css('.project-file-name-container a').content
  end

  def get_mod_name(page)
    page.at_css('h1.project-title span').content
  end

  def extract_mod_version(modname, filename)
    start = 0
    j = 0
    skipped_name = false
    filename.split('').each_with_index { |c, i|
      cm = modname[j]

      if skipped_name
        if c != ' ' && c != '-'
          start = i
          break
        end
      elsif !(cm =~ /[A-Za-z0-9]/) || cm.downcase == cm.downcase
        j += 1
        if j == modname.length
          skipped_name = true
        end
      end
    }

    version = filename[start..filename.length]
    if version.downcase.ends_with? '.jar'
      version[0..-5] # exclude '.jar'
    else
      version
    end
  end
end
