class Mod < ApplicationRecord
  MINECRAFT_VERSION = '1.7.10'

  def self.minecraft_version
    MINECRAFT_VERSION
  end
end
