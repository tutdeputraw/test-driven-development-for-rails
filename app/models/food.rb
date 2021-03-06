class Food < ApplicationRecord
  belongs_to :category
  
  validates :name, presence: true, uniqueness: true  
  validates_numericality_of :price, greater_than_or_equal_to: 0.01
  validates :category_id,  presence: true
  validate :word_count_is_less_than_or_equal_to_2_words

  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end

  def word_count_is_less_than_or_equal_to_2_words
    if self.name.present? && self.name.split.size > 2
      errors.add(:name, "You must have less than 2 words")
    end
  end
end
