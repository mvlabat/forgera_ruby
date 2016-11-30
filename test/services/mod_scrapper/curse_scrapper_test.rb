require 'test_helper'

class CurseScrapperTested < CurseScrapper
  def extract_mod_version(modname, filename)
    super(modname, filename)
  end
end

class CurseScrapperTest < ActiveSupport::TestCase
  test 'it scraps' do
    mod = CurseScrapper.new.scrap('https://minecraft.curseforge.com/projects/multiworld')
    assert mod.just?

    mod = mod.just
    assert_equal 'MultiWorld', mod.name
    assert_equal '1.7.2-v-1.2.7', mod.version
  end

  test 'it extracts' do
    scrapper = CurseScrapperTested.new
    assert_equal('1.1.1-1', scrapper.extract_mod_version('MOD', 'mod-1.1.1-1'))
    assert_equal('1.1.1-1', scrapper.extract_mod_version('MOD', 'mod--1.1.1-1'))
    assert_equal('1.1.1-1', scrapper.extract_mod_version('MOD', 'mod-1.1.1-1.jar'))
    assert_equal('1.1.1-1', scrapper.extract_mod_version('MOD', 'mod--1.1.1-1.jar'))

    assert_equal('(1.1.1-1)', scrapper.extract_mod_version('MOD', 'mod (1.1.1-1)'))
    assert_equal('(1.1.1-1)', scrapper.extract_mod_version('MOD', 'mod  (1.1.1-1)'))
    assert_equal('(1.1.1-1)', scrapper.extract_mod_version('MOD', 'mod (1.1.1-1).jar'))
    assert_equal('(1.1.1-1)', scrapper.extract_mod_version('MOD', 'mod  (1.1.1-1).jar'))

    assert_equal('(1.1.1-1)', scrapper.extract_mod_version('awesome-mod', 'awesome-mod (1.1.1-1)'))
    assert_equal('(1.1.1-1)', scrapper.extract_mod_version('awesome-mod', 'awesome-mod  (1.1.1-1)'))
    assert_equal('(1.1.1-1)', scrapper.extract_mod_version('awesome--mod', 'awesome-mod (1.1.1-1).jar'))
    assert_equal('(1.1.1-1)', scrapper.extract_mod_version('awesome--mod', 'awesome-mod  (1.1.1-1).jar'))
  end
end
