class CreateAttachments < ActiveRecord::Migration[8.1]
  def change
    create_table :attachments do |t|
      t.string :file_name
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
