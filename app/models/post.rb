class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :tags, presence: true

  after_create :schedule_deletion

  private

  def schedule_deletion
    PostDeletionJob.set(wait_until: 24.hours.from_now).perform_later(self.id)
  end
end
