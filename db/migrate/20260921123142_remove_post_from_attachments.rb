class RemovePostFromAttachments < ActiveRecord::Migration[8.1]
  def change
    remove_reference :attachments, :post, null: false, foreign_key: true
  end
end
