class Task < ApplicationRecord
  belongs_to :status
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
end
