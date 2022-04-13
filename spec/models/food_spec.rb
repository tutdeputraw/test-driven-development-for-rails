require 'rails_helper'

RSpec.describe Food, type: :model do
  it 'is valid with a name and a description' do
    Category.create(name: 'category1')
    
    food = Food.new(
      name: 'Nasi Uduk',
      description: 'Betawi style steamed rice cooked in coconut milk. Delicious!',
      price: 15000.0,
      category_id: 1
    )

    expect(food).to be_valid
  end

  it 'is invalid without a name' do
    Category.create(name: 'category1')
    
    food = Food.new(
      name: nil,
      description: 'Betawi style steamed rice cooked in coconut milk. Delicious!',
      price: 15000.0,
      category_id: 1
    )

    food.valid?

    expect(food.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    Category.create(name: 'category1')
    
    food1 = Food.create(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 10000.0,
      category_id: 1
    )
    
    food2 = Food.new(
      name: "Nasi Uduk",
      description: "Just with a different description.",
      price: 10000.0,
      category_id: 1
    )

    food1.valid?
    food2.valid?
    
    expect(food2.errors[:name]).to include("has already been taken")
  end

  describe 'self#by_letter' do
    it "should return a sorted array of results that match" do
      Category.create(name: 'category1')
    
      food1 = Food.create(
        name: "Nasi Uduk",
        description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
        price: 10000.0,
        category_id: 1
      )

      food2 = Food.create(
        name: "Kerak Telor",
        description: "Betawi traditional spicy omelette made from glutinous rice cooked with egg and served with serundeng.",
        price: 8000.0,
        category_id: 1
      )

      food3 = Food.create(
        name: "Nasi Semur",
        description: "Based on dongfruit, this menu promises a unique and delicious taste with a small hint of bitterness.",
        price: 8000.0,
        category_id: 1
      )

      food1.valid?
      food2.valid?
      food3.valid?

      expect(Food.by_letter("N")).to eq([food3, food1])
    end
  end

  it 'Food model does not accept non numeric values for "price" field' do
    Category.create(name: 'category1')
    
    food = Food.create(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: "joni",
      category_id: 1
    )

    food.valid?

    expect(food.errors[:price]).to include("is not a number")
  end

  it 'Food model does not accept "price" less than 0.01' do
    Category.create(name: 'category1')
    
    food = Food.create(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 0.000001,
      category_id: 1
    )

    food.valid?

    expect(food.errors[:price]).to include("must be greater than or equal to 0.01")
  end

  it 'price field should have values less than or equal 2 words' do
    Category.create(name: 'category1')
    
    food = Food.create(
      name: "Nasi Uduk Jawa",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 0.001,
      category_id: 1
    )

    food.valid?

    expect(food.errors[:name]).to include("You must have less than 2 words")
  end

  it 'is invalid with empty category_id' do
    food = Food.create(
      name: "Nasi Uduk",
      description: "Betawi style steamed rice cooked in coconut milk. Delicious!",
      price: 5000,
    )

    food.valid?

    expect(food.errors[:category_id]).to include("can't be blank")
  end
end
