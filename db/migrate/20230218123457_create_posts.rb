class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :tags, null: false, array: true, default: []
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :posts, :tags, using: 'gin'
  end
end
