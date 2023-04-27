class SearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  MODELS = {
    "User" => "user",
    "Book" => "book"
  }

  METHODS = {
    "完全一致" => "match_all",
    "前方一致" => "match_forward",
    "後方一致" => "match_backward",
    "部分一致" => "match_partial"
  }

  attribute :keyword, :string
  attribute :model, :string
  attribute :method, :string

  def search
    if model == "user"
      search_users
    else
      search_books
    end
  end

  def search_users
    case method
    when "match_all"
      User.where(name: keyword)
    when "match_forward"
      User.where("name LIKE?","#{keyword}%")
    when "match_backward"
      User.where("name LIKE?","%#{keyword}")
    when "match_partial"
      User.where("name LIKE?","%#{keyword}%")
    else
      User.none
    end
  end

  def search_books
    case method
    when "match_all"
      Book.where(title: keyword)
    when "match_forward"
      Book.where("title LIKE?","#{keyword}%")
    when "match_backward"
      Book.where("title LIKE?","%#{keyword}")
    when "match_partial"
      Book.where("title LIKE?","%#{keyword}%")
    else
      Book.none
    end
  end
end
