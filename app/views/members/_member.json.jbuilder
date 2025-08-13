json.extract! member, :id, :name, :surname, :email, :birthday, :number_of_club_games_played, :current_rank, :created_at, :updated_at
json.url member_url(member, format: :json)
