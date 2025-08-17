class Member < ApplicationRecord
    has_many :matches_as_player_one, 
        class_name: "Match",            
        foreign_key: "player_one_id", 
        dependent: :destroy

    has_many :matches_as_player_two, 
        class_name: "Match", 
        foreign_key: "player_two_id", 
        dependent: :destroy
        
    def full_name
        self.name + ' ' + self.surname
    end
end
