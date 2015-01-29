class AddRecipesAndIngredients < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.column(:name, :string)
      t.column(:instructions, :string)
      t.column(:rating, :integer)

      t.timestamps
    end

    create_table(:ingredients) do |t|
      t.column(:name, :string)

      t.timestamps
    end

    create_table(:ingredients_recipes) do |t|
      t.column(:ingredient_id, :integer)
      t.column(:recipe_id, :integer)

      t.timestamps
    end    
  end
end
