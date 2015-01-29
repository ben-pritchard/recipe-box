require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  @recipes = Recipe.all()
  erb(:index)
end

post("/add_recipe") do
  name = params.fetch("name")
  @new_recipe = Recipe.create({:name => name})
  erb(:add_recipe)
end

post("/add_ingredient") do
  name = params.fetch("ingredient")
  recipe_id = params.fetch("recipe_id").to_i()
  @ingredient = Ingredient.create({:name => name, :recipe_ids => [recipe_id]})
  @new_recipe = Recipe.find(recipe_id)
  @ingredients = @new_recipe.ingredients()
  erb(:add_recipe)
end

patch("/add_instructions") do
  instructions = params.fetch("instructions")
  Recipe.find(params.fetch("recipe_id").to_i()).update({:instructions => instructions})
  redirect("/")
end
