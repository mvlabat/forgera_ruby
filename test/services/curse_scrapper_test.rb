require 'test_helper'

class CurseScrapperTest < ActiveSupport::TestCase
  test 'it scraps' do
    mod = CurseScrapper.new.scrap('https://minecraft.curseforge.com/projects/multiworld')
    assert_equal mod.name, 'MultiWorld'
    assert_equal mod.version, '1.7.2-v-1.2.7'
  end
end
