class Match < ApplicationRecord
    belongs_to :player_one, class_name: "Member"
    belongs_to :player_two, class_name: "Member"
    belongs_to :winner, class_name: "Member", optional: true

    attr_accessor :winner_result

    before_validation :map_winner_result
    validate :different_players

    after_create :calculate_rank
    after_create :increment_games_played  

    def calculate_rank
        #draw
        if winner.nil?
            return if (player_one.current_rank - player_two.current_rank).abs == 1
            
            shift_up_by_one(player_two) if player_one.current_rank < player_two.current_rank
            shift_up_by_one(player_one) if player_one.current_rank > player_two.current_rank
        #player one win
        elsif winner == player_one
            return if player_one.current_rank < player_two.current_rank

            shift_down_by_one(player_two)
            shift_up_by_x(player_one, player_two)
        #player two win
        else
            return if player_two.current_rank < player_one.current_rank

            shift_up_by_x(player_two, player_one)
            shift_down_by_one(player_one)
        end
    end

    private

    def shift_up_by_one(player)
        rank = player.current_rank
        old_rank_player = Member.find_by(current_rank: rank - 1)
        old_rank_player.current_rank += 1
        old_rank_player.save
        player.current_rank -= 1
        player.save
    end

    def shift_down_by_one(player)
        rank = player.current_rank
        old_rank_player = Member.find_by(current_rank: rank + 1)
        old_rank_player.current_rank -= 1
        old_rank_player.save
        player.current_rank += 1
        player.save
    end

    def shift_up_by_x(winning_player, losing_playing)
        shift_by = (winning_player.current_rank - losing_playing.current_rank)/2
        shift_by.times do |i|
            shift_member_down =  Member.find_by(current_rank: winning_player.current_rank - (i + 1))
            shift_member_down.current_rank +=1
            shift_member_down.save
        end
        winning_player.current_rank -= shift_by
        winning_player.save
    end

    def map_winner_result
        case winner_result
        when "player_one"
            self.winner_id = player_one_id
        when "player_two"
            self.winner_id = player_two_id
        when "draw"
            self.winner_id = nil
        end
    end

    def increment_games_played
        player_one.increment!(:number_of_club_games_played)
        player_two.increment!(:number_of_club_games_played)
    end

    def different_players
      errors.add(:player_two, "must be different from player one") if player_one_id == player_two_id
    end
end
