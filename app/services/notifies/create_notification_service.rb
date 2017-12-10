class Notifies::CreateNotificationService
  attr_reader :current_account, :target_account, :model, :action

  def initialize args
    @current_account = args[:current_account]
    @target_account = args[:target_account]
    @model = args[:model]
    @action = args[:action]
  end

  def perform
    model.notifies.create account_id: current_account.id, target_id: target_account.id,
      action: action, status: :unread
  end
end
