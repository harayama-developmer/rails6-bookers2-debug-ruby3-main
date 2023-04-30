class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @search_form = SearchForm.new(search_params)

    @results = @search_form.search
  end

  def categories
    @categories_form = CategoriesForm.new(categories_params)

    @results = @categories_form.search
  end

  private

  def search_params
    params.fetch(:q, '').permit(:keyword, :model, :method)
  end

  def categories_params
    params.fetch(:q, '').permit(:category)
  end
end
