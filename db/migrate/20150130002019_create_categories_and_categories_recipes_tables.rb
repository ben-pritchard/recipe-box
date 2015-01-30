class CreateCategoriesAndCategoriesRecipesTables < ActiveRecord::Migration
  def change
    create_table(:categories) do |t|
      t.column(:name, :string)

      t.timestamps
    end

    create_table(:categories_recipes) do |t|
      t.column(:recipe_id, :integer)
      t.column(:category_id, :integer)

      t.timestamps
    end
  end
end
