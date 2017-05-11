class CreateSocialInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :social_interests do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.integer :followerscount

      t.timestamps
    end
  end
end
