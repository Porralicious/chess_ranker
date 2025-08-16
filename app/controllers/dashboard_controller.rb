class DashboardController < ApplicationController
  def index
    @leaderboard = Member.order(:current_rank).limit(10)
    @recent_matches = Match.includes(:player_one,:player_two,:winner).order(created_at: :desc).limit(5)
  end
end
