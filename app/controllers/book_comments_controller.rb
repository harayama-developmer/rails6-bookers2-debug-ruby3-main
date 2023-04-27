class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    unless @book_comment.save
      render "errors"
    end
  end

  def destroy
    book_comment = @book.book_comments.where(user: current_user).find(params[:id])
    book_comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
