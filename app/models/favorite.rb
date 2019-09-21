class Favorite < ApplicationRecord
  belongs_to :favlist
  belongs_to :micropost
end
