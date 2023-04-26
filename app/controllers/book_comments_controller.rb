class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      redirect_to book_path(@book)
    else
      # バリデーションエラー時の要件が不明だったため、とりあえずnoticeでメッセージを出力するようにしています。
      redirect_to book_path(@book), notice: @book_comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    book_comment = @book.book_comments.find(params[:id])
    # 自分のコメントしか削除できない
    if book_comment.user == current_user
      book_comment.destroy
    end
    redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
