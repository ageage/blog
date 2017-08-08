class Post < ActiveRecord::Base
  acts_as_taggable

  STATUS_VALUES = ['private', 'public'].map(&:freeze).freeze


  validates :title, presence: true, length: {maximum: 200}
  validates :body, :posted_at, presence: true
  validates :status, inclusion: {in: STATUS_VALUES}

  scope :common, -> {where(status: STATUS_VALUES[1])}
end
