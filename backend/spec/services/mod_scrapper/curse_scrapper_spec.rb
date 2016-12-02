require 'rails_helper'

class CurseScrapperTested < CurseScrapper
  def extract_mod_version(modname, filename)
    super(modname, filename)
  end
end

RSpec.describe "CurseScrapper" do
  it 'extracts mod version' do
    scrapper = CurseScrapperTested.new
    expect(scrapper.extract_mod_version('MOD', 'mod-1.1.1-1')).to eq('1.1.1-1')
    expect(scrapper.extract_mod_version('MOD', 'mod--1.1.1-1')).to eq('1.1.1-1')
    expect(scrapper.extract_mod_version('MOD', 'mod-1.1.1-1.jar')).to eq('1.1.1-1')
    expect(scrapper.extract_mod_version('MOD', 'mod--1.1.1-1.jar')).to eq('1.1.1-1')

    expect(scrapper.extract_mod_version('MOD MOD MOD MOD', 'modmodmodmod (1.1.1-1)')).to eq('(1.1.1-1)')
    expect(scrapper.extract_mod_version('MOD MOD MOD MOD', 'modmodmodmod  (1.1.1-1)')).to eq('(1.1.1-1)')
    expect(scrapper.extract_mod_version('MOD MOD MOD MOD', 'modmodmodmod (1.1.1-1).jar')).to eq('(1.1.1-1)')
    expect(scrapper.extract_mod_version('MOD MOD MOD MOD', 'modmodmodmod  (1.1.1-1).jar')).to eq('(1.1.1-1)')

    expect(scrapper.extract_mod_version('awesome-mod', 'awesome-mod   (1.1.1-1)')).to eq('(1.1.1-1)')
    expect(scrapper.extract_mod_version('awesome-mod', 'awesome-mod    (1.1.1-1)')).to eq('(1.1.1-1)')
    expect(scrapper.extract_mod_version('awesome--mod', 'awesome-mod   (1.1.1-1).jar')).to eq('(1.1.1-1)')
    expect(scrapper.extract_mod_version('awesome--mod', 'awesome-mod    (1.1.1-1).jar')).to eq('(1.1.1-1)')
  end

  it 'scraps' do
    mod = CurseScrapper.new.scrap('https://minecraft.curseforge.com/projects/multiworld')
    expect(mod.name).to eq('MultiWorld')
    expect(mod.version).to eq('1.7.2-v-1.2.7')
  end

  it 'scraps (even with trailing slash)' do
    mod = CurseScrapper.new.scrap('https://minecraft.curseforge.com/projects/multiworld/')
    expect(mod.name).to eq('MultiWorld')
    expect(mod.version).to eq('1.7.2-v-1.2.7')
  end

  it "doesn't find" do
    expect {
      CurseScrapper.new.scrap('https://minecraft.curseforge.com/projects/fancy-block-particles')
    }.to raise_error(Scrapper::UnsupportedVersionError)
  end
end
