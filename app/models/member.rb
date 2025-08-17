class Member < ApplicationRecord
    def full_name
        self.name + ' ' + self.surname
    end
end
