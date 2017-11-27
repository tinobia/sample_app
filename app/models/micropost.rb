class Micropost < ApplicationRecord
  belongs_to :user
  scope :another_sort, ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content.maximum}
  validate  :picture_size
  scope :feed_user, ->(id){where("user_id = ?", id)}

  private

  def picture_size
    return unless picture.size > Settings.picture.max_size.megabytes
    errors.add :picture, I18n.t("models.micropost.error")
  end
end
