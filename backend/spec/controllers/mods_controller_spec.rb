require 'rails_helper'

RSpec.describe ModsController, type: :controller do
  describe 'GET  index' do
    it 'gets all mods' do
      get :index
      compare_data(response.body, Mod.all)
    end
  end

  describe 'POST mod' do
    it 'posts a mod' do
      request.headers['CONTENT_TYPE'] = 'application/json'
      post :create, params: { "project_url": "https://minecraft.curseforge.com/projects/multiworld" }
      compare_data(response.body, Mod.last)
    end
  end

  describe 'UPDATE mods' do
    it 'updates all the mods' do
      get :check_updates
      mods = Mod.all
      compare_data(response.body, mods)

      expect(mods[0].name).to eq('Thaumcraft Mob Aspects')
      expect(mods[0].version).to eq('1.7.2-2A')

      expect(mods[1].name).to eq('Explosive Mining')
      expect(mods[1].version).to eq('2-1.0-mc1.7.10-forge10.13.0.1160')

      expect(mods[2].name).to eq('FeedCraft')
      expect(mods[2].version).to eq('0.5.7 - Beta')
    end
  end
end

def compare_data(response_body, data)
  expect(JSON.parse(response_body)).to eq(JSON.parse(data.to_json))
end
