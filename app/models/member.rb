class Member < ApplicationRecord
    has_many :matches_as_player_one, 
        class_name: "Match",            
        foreign_key: "player_one_id", 
        dependent: :destroy

    has_many :matches_as_player_two, 
        class_name: "Match", 
        foreign_key: "player_two_id", 
        dependent: :destroy

    after_destroy :shift_lower_ranks_up

    def full_name
        self.name + ' ' + self.surname
    end

    private

    def shift_lower_ranks_up
        Member.where("current_rank > ?", current_rank).update_all("current_rank = current_rank - 1")
    end
end

