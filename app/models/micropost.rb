class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content.maximum}
  validate  :picture_size
  scope :another_sort, ->{order(created_at: :desc)}
  scope :feed_users, ->(following_ids, id){where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)}

  private

  def picture_size
    return unless picture.size > Settings.picture.max_size.megabytes
    errors.add :picture, I18n.t("models.micropost.error")
  end
end
