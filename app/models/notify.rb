class Notify < ApplicationRecord
  belongs_to :account
  belongs_to :notifyable, polymorphic: true

  after_create_commit {Notifies::BroadcastNotificationService.new(self).perform}

  delegate :name, to: :account, prefix: true, allow_nil: true
  enum action: [:up_vote, :down_vote, :comment_article, :answer_question, :comment_answer]

  def noti_content
    case self.action
    when "up_vote", "down_vote"
      I18n.t("notify.#{self.action}", post: self.notifyable.title.truncate(15))
    when "comment_article", "answer_question", "comment_answer"
      I18n.t("notify.#{self.action}", from_name: self.account_name)
    end
  end
end
