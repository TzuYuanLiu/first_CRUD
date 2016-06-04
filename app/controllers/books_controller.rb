class BooksController < ApplicationController
	before_action :set_book, :only => [ :show, :edit, :update, :destroy ]


	def index
		@book = Book.new
		@books = Book.page(params[:page]).per(10)  
	end

	def show
		@page_title = @book.name

  		respond_to do |format|
		    format.html { @page_title = @book.name } # show.html.erb
		    format.xml # show.xml.builder
		    format.json { render :json => { id: @book.id, name: @book.name }.to_json }		
		end
	end


	def new
		@book = Book.new
	end

	def create	  
		@book = Book.new(book_params)
		@book.save

		if @book.save
		  	flash[:notice] = "書本新增成功"
		    redirect_to books_path
		else
			render :action => :new
		end
	end

	def edit
	end

	def update

  		@book.update(book_params)

  		  if @book.update(book_params)
  		  	flash[:notice] = "書本更新成功"
		    redirect_to book_path(@book)
		  else
		    render :action => :index
		  end
	end

	def destroy
	  @book.destroy
	  flash[:alert] = "書本成功刪除"
	  redirect_to books_path
	end


	def set_book
	  	@book = Book.find(params[:id])
	end

	private

	def book_params
	  params.require(:book).permit(:name, :description)
	end

end
