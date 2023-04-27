class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    favorite = @book.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
