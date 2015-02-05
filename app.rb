require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  @recipes = Recipe.all()
  erb(:index)
end

post("/recipes") do
  name = params.fetch("name")
  @new_recipe = Recipe.new({:name => name})
  if @new_recipe.save()
    erb(:add_recipe)
  else
    erb(:error)
  end
end

post("/ingredients") do
  name = params.fetch("ingredient")
  recipe_id = params.fetch("recipe_id").to_i()
  @ingredient = Ingredient.create({:name => name, :recipe_ids => [recipe_id]})
  @new_recipe = Recipe.find(recipe_id)
  @ingredients = @new_recipe.ingredients()
  erb(:add_recipe)
end

patch("/instructions") do
  instructions = params.fetch("instructions")
  Recipe.find(params.fetch("recipe_id").to_i()).update({:instructions => instructions})
  redirect("/")
end

get("/recipes/:id") do
  recipe_id = params.fetch("id").to_i()
  @recipe = Recipe.find(recipe_id)
  erb(:recipe)
end

get("/clear") do
  Recipe.destroy_all()
  redirect("/")
end

patch("/rating") do
  rating = params.fetch("rating").to_i()
  Recipe.find(params.fetch("recipe_id")).update({:rating => rating})
  redirect("/")
end

get("/rating4") do
  @recipes = Recipe.rating(4)
  erb(:index)
end

post("/add_dummy_recipes") do
  pizza = Recipe.create({:name => "Pizza", :instructions => "Bake it up, yo!", :rating => 5})
  pizza_recipe_id = pizza.id
  ingredient = Ingredient.create({:name => "Cheese", :recipe_ids => [pizza_recipe_id]})
  ingredient = Ingredient.create({:name => "Tomato Sauce", :recipe_ids => [pizza_recipe_id]})
  ingredient = Ingredient.create({:name => "Dough", :recipe_ids => [pizza_recipe_id]})

  curry = Recipe.create({:name => "Curry Rice", :instructions => "Chop stuff up, throw it in a pot, simmer it, add the curry cubes, and then pour over rice, yo!", :rating => 5})
  curry_recipe_id = curry.id
  ingredient = Ingredient.create({:name => "Veggies", :recipe_ids => [curry_recipe_id]})
  ingredient = Ingredient.create({:name => "Rice", :recipe_ids => [curry_recipe_id]})
  ingredient = Ingredient.create({:name => "Curry", :recipe_ids => [curry_recipe_id]})

  stir_fry = Recipe.create({:name => "Stir Fry", :instructions => "Fry the veggies then throw them over rice, yo!", :rating => 4})
  stir_fry_recipe_id = stir_fry.id
  ingredient = Ingredient.create({:name => "Veggies", :recipe_ids => [stir_fry_recipe_id]})
  ingredient = Ingredient.create({:name => "Rice", :recipe_ids => [stir_fry_recipe_id]})

  omelette = Recipe.create({:name => "omelette", :instructions => "Fry the big mess, yo!", :rating => 4})
  omelette_recipe_id = omelette.id
  ingredient = Ingredient.create({:name => "Cheese", :recipe_ids => [omelette_recipe_id]})
  ingredient = Ingredient.create({:name => "Veggies", :recipe_ids => [omelette_recipe_id]})
  ingredient = Ingredient.create({:name => "Eggs", :recipe_ids => [omelette_recipe_id]})

  redirect "/"
end

post "/rate/:recipe_id" do
  id = params.fetch("recipe_id").to_i
  rating = params.fetch("rating").to_i
  @recipe = Recipe.find(id)
  @recipe.update({:rating => rating})
  erb :recipe
end
