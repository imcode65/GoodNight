class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows, id: :uuid do |t|
      t.references :follower, foreign_key: { to_table: :users }, type: :uuid
      t.references :following_user, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end

    add_index :follows, [:follower_id, :following_user_id], name: 'unique_follows', unique: true
  end
end
