class Answer < ApplicationRecord
  belongs_to :account
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :notifies, as: :notifyable
  has_many :votes, as: :voteable

  validates :content, presence: true

  ANSWER_ATTRIBUTES = [:content, :total_vote, :question_id]

  delegate :name, to: :account, prefix: true, allow_nil: true
  delegate :account_avatar_url, to: :account, prefix: false, allow_nil: true

  def init_vote account_id
    votes.find_by(account_id: account_id) || votes.build
  end

  def all_vote
    all_vote_up - all_vote_down
  end

  def all_vote_down
    votes.vote_down.count
  end

  def all_vote_up
    votes.vote_up.count
  end
end
