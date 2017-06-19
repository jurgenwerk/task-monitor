class AppMonitor < ApplicationRecord
  belongs_to :account
  has_many :tasks, dependent: :destroy
  has_many :task_instances, through: :tasks
  validates :name, presence: true
  validates :name, uniqueness: { scope: :account }
  before_validation :create_api_key

  def create_api_key
    return unless new_record?
    self.api_key = SecureRandom.hex
  end
end
