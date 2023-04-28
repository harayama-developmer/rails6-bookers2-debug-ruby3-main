class CreateFootprints < ActiveRecord::Migration[6.1]
  def change
    create_table :footprints do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :footprintable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
