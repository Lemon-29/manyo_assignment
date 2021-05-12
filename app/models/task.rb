class Task < ApplicationRecord
  belongs_to :user
  validates :title, presesnce: true
  validates :content, presence: true
end
