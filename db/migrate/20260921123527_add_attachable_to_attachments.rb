class AddAttachableToAttachments < ActiveRecord::Migration[8.1]
  def change
    add_reference :attachments, :attachable, polymorphic: true, null: false
  end
end
