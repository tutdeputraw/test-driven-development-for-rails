class Food < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates_numericality_of :price, greater_than_or_equal_to: 0.01

  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end
end
