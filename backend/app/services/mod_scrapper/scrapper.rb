module Scrapper
  class HtmlParseError < StandardError; end
  class UnsupportedVersionError < StandardError; end
  class InvalidProjectURLError < StandardError; end

  def raise_invalid_html(project_url, error = "Unexpected html structure for ''#{project_url}''")
    raise HtmlParseError.new, error
  end

  def raise_no_mod(version, error = "No mod with '#{version}' version")
    raise UnsupportedVersionError.new, error
  end

  def raise_invalid_project_url(project_url, error = "Invalid project url '#{project_url}'")
    raise HtmlParseError.new, error
  end
end
