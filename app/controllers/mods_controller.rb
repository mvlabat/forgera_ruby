class ModsController < ApplicationController
  def test
    @mods = Mod.all
  end
end
