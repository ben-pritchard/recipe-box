class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:ingredients)
  validates(:name, :presence => true)
  before_save(:upcase_name)

  scope(:rating, -> (stars) do
    where({:rating => stars})
  end)

  private
    define_method(:upcase_name) do
      self.name=(name().upcase())
    end
end
