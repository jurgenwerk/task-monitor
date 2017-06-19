class AccountUser
  attr_reader :account, :user, :access

  def initialize(account:, user:)
    @account = account
    @user = user
    @access = user.user_account_accesses.where(account_id: account.id).first
  end

  def app_monitors
    @account.app_monitors
  end

  def task_instances
    TaskInstance
      .joins(:task)
      .joins(task: :app_monitor)
      .where("app_monitors.account_id = ?", @account.id)
  end
end
