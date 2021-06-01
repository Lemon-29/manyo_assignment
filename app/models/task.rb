class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :title, presence: true
  validates :content, presence: true
  # validates :expired_at, presence: true
  # validates :status, presence: true
  validates :user_id, presence: true
  enum status: { Pending: 1, On_going: 2, Completed: 3 }
  enum priority: { Low: 1, Middle: 2, High: 3 }
  
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%")}
  scope :search_status, -> (search_status) { where(status: search_status)}
  scope :search_label, -> (search_label) { joins(:labels).where(labels: { id: search_label })}
end
