class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def index
    @books = Book.includes(:favorites_user).sort {|a,b| b.favorites_user.size <=> a.favorites_user.size}
    @user = current_user
    @book = Book.new
    @book_comment = BookComment.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
    else
     @books = Book.all
     @user = current_user
     render("books/index")
    end
  end
  
  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = current_user
    @book_comment = BookComment.new
    
  end
  
  def edit
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to  books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
    flash[:notice] = "successfully"
    redirect_to book_path(@book.id)
    else
     @user = current_user
     render("books/edit")
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
 private

  def book_params
  params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  
end
