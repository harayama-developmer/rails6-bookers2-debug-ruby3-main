class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @search_form = SearchForm.new(search_params)

    @results = @search_form.search
  end

  private

  def search_params
    params.fetch(:q, '').permit(:keyword, :model, :method)
  end
end
