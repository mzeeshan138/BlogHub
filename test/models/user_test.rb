require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "can attach a profile image" do
    user = users(:one)

    user.avatar.attach(
      io: StringIO.new("fake image content"),
      filename: "avatar.png",
      content_type: "image/png"
    )

    assert user.save
    assert user.avatar.attached?
    assert_equal "avatar.png", user.avatar.filename.to_s
  end

  test "rejects non-image profile files" do
    user = users(:one)

    user.avatar.attach(
      io: StringIO.new("plain text"),
      filename: "notes.txt",
      content_type: "text/plain"
    )

    assert_not user.valid?
    assert_includes user.errors[:avatar], "must be a PNG, JPEG, or GIF image"
  end
end
