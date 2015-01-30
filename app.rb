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

get("/ratings/:id") do
  recipe_id = params.fetch("id").to_i()
  @recipe = Recipe.find(recipe_id)
  erb(:ratings)
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
