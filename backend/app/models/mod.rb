class Mod < ApplicationRecord
  MINECRAFT_VERSION = '1.7.10'

  def self.minecraft_version
    MINECRAFT_VERSION
  end

  def merge(mod)
    self.name = mod.name
    self.version = mod.version
    self
  end
end
