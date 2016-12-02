require 'mechanize'

class CurseScrapper
  include Scrapper

  def scrap(url)
    mod = Mod.new(project_url: url)

    mechanize = Mechanize.new
    begin
      page = mechanize.get(url + (url[-1] == '/' ? 'files' : '/files'))
    rescue Mechanize::ResponseCodeError
      raise_invalid_project_url(url)
    end

    mod_node = get_mod_node(page)
    mod.name = get_mod_name(page)
    mod.version = extract_mod_version(mod.name, get_jar_filename(mod_node))
    mod
  end

  protected

  def get_mod_node(page)
    node_set = page.css('.listing-project-file tr.project-file-list-item')
    if node_set.empty?
      raise_invalid_html(url)
    end
    node_set.each do |subnode|
      return subnode if has_version(subnode, Mod.minecraft_version)
    end
    raise_no_mod(Mod.minecraft_version)
  end

  def has_version(node, version)
    get_node_content(node, '.version-label') == version
  end

  def get_jar_filename(node)
    get_node_content(node, '.project-file-name-container a')
  end

  def get_mod_name(page)
    get_node_content(page, 'h1.project-title span')
  end

  def get_node_content(parent, selector)
    inner_node = parent.at_css(selector)
    if inner_node.nil?
      raise_invalid_html(url)
    end
    inner_node.content
  end

  def extract_mod_version(modname, filename)
    regex_filter = /[A-Za-z0-9]/

    modname_filtered_length = modname.scan(regex_filter).count

    start = 0
    j = 0 # iterates through filtered modname
    skipped_name = false

    # We are going to look for the start variable value, which points to the position,
    # where mod name is skipped and version begins.
    filename.split('').each_with_index { |c, i|
      if skipped_name
        # We do not use regex_filter, because version can start with '(', for instance,
        # but it may be separated with spaces or dashes from the modname.
        if c != ' ' && c != '-'
          start = i
          break
        end
      elsif c =~ regex_filter
        j += 1
        if j == modname_filtered_length
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
