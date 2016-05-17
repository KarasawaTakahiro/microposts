class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :follower, index: true, foreign_key: true
      t.references :followed, index: true, foreign_key: true

      t.timestamps null: false

      # follower_id と followed_id のペアでユニーク制約
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
