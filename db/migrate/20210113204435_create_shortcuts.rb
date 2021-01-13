class CreateShortcuts < ActiveRecord::Migration[6.1]
  def change
    create_table :shortcuts, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.text :url, null: false
      t.string :key, null: false

      t.timestamps
    end

    add_index :shortcuts, :key, unique: true
  end
end
