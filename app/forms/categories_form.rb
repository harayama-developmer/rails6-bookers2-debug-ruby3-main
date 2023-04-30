class CategoriesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :category, :string

  def search
    Book.where("category LIKE?","%#{category}%")
  end
end
