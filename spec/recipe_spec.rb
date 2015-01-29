require("spec_helper")

describe(Recipe) do
  it { should have_and_belong_to_many(:ingredients) }

  it("validates the presence of the name field for Recipe objects") do
    pizza = Recipe.new({:name => ""})
    expect(pizza.save()).to(eq(false))
  end

  it("upcases the name of recipe") do
    recipe = Recipe.create({:name => "frUIt saLAd"})
    expect(recipe.name()).to(eq("FRUIT SALAD"))
  end

  describe(".rating") do
    it("returns the recipes with a given rating") do
      rating_5 = Recipe.create({:name => "Banana Split", :rating => 5})
      rating_5_again = Recipe.create({:name => "Cinnamon Buns", :rating => 5})
      rating_3 = Recipe.create({:name => "Coffee", :rating => 3})
      rating_1 = Recipe.create({:name => "Boiled Water", :rating => 1})
      rated_5 = [rating_5, rating_5_again]
      expect(Recipe.rating(5)).to(eq(rated_5))
    end
  end

end
