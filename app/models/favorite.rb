class Favorite < ApplicationRecord
  belongs_to :musicevent
  belongs_to :user
end
