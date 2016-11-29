class CreateMods < ActiveRecord::Migration[5.0]
  def change
    create_table :mods do |t|
      t.string :name
      t.string :version
      t.string :project_url

      t.timestamps
    end
  end
end
