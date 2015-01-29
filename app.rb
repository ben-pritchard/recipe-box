require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  @recipes = Recipe.all()
  erb(:index)
end

post("/recipes") do
  name = params.fetch("name")
  @new_recipe = Recipe.create({:name => name})
  erb(:add_recipe)
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
  erb(:show_recipe)
end
