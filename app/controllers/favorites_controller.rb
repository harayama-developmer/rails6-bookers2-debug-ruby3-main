class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    favorite = @book.favorites.new(user_id: current_user.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    favorite = @book.favorites.find_by(user_id: current_user.id)
    favorite.destroy
    redirect_to request.referer
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
