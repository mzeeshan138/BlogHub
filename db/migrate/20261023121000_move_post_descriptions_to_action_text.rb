class MovePostDescriptionsToActionText < ActiveRecord::Migration[8.1]
  class PostRecord < ActiveRecord::Base
    self.table_name = "posts"
  end

  class RichTextRecord < ActiveRecord::Base
    self.table_name = "action_text_rich_texts"
  end

  def up
    PostRecord.reset_column_information

    PostRecord.find_each do |post|
      next if post.description.blank?

      RichTextRecord.create!(
        name: "description",
        record_type: "Post",
        record_id: post.id,
        body: post.description
      )
    end

    remove_column :posts, :description, :text
  end

  def down
    add_column :posts, :description, :text
    PostRecord.reset_column_information

    RichTextRecord.where(name: "description", record_type: "Post").find_each do |rich_text|
      plain_text = ActionText::Content.new(rich_text.body).to_plain_text
      PostRecord.where(id: rich_text.record_id).update_all(description: plain_text)
    end
  end
end
