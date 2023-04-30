class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[show edit update destroy]
  before_action :redirect_index_unless_mine, only: %i[edit update destroy]

  def index
    # 過去一週間でいいねの合計カウントが多い順に投稿を表示
    @books = Book.left_joins(:week_favorites).group(:id).order("count(book_id) desc")
    @book = Book.new
  end

  def show
    @book.footprint!(current_user)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def redirect_index_unless_mine
    redirect_to books_path unless @book.user == current_user
  end
end
