class Notify < ApplicationRecord
  belongs_to :account
  belongs_to :notifyable, polymorphic: true

  after_create_commit {Notifies::BroadcastNotificationService.new(self).perform}

  delegate :name, to: :account, prefix: true, allow_nil: true
  enum action: [:vote_up, :vote_down, :comment_article, :answer_question, :comment_answer, :reply_comment]
  enum status: [:unread, :read]

  def noti_content
    case self.action
    when "vote_up", "vote_down"
      I18n.t("notify.#{self.action}.#{self.notifyable_type.downcase}")
    when "comment_article", "answer_question", "comment_answer", "reply_comment"
      I18n.t("notify.#{self.action}", from_name: self.account_name)
    end
  end
end
