class CreateConversationUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :conversation_users do |t|
      t.belongs_to :conversation, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
