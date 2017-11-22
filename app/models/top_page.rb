class TopPage
  def top_lawyers_ranking
    @top_lawyers ||= Account.top_lawyer Settings.ranking.top_page
  end
end
