class User < ApplicationRecord
  has_many :tasks, dependent: :destroyssion
end
