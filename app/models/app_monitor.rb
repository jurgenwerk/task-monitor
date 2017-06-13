class AppMonitor < ApplicationRecord
  belongs_to :account
  has_many :tasks, dependent: :destroy

  before_validation :create_api_key

  def create_api_key
    return unless new_record?
    self.api_key = SecureRandom.hex
  end
end
