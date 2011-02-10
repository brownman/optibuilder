class LogBooksController < ApplicationController
  # GET /log_books
  # GET /log_books.xml
  def index
    @log_books = LogBook.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @log_books }
    end
  end

  # GET /log_books/1
  # GET /log_books/1.xml
  def show
    @log_book = LogBook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @log_book }
    end
  end

  # GET /log_books/new
  # GET /log_books/new.xml
  def new
    @log_book = LogBook.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @log_book }
    end
  end

  # GET /log_books/1/edit
  def edit
    @log_book = LogBook.find(params[:id])
  end

  # POST /log_books
  # POST /log_books.xml
  def create
    @log_book = LogBook.new(params[:log_book])

    respond_to do |format|
      if @log_book.save
        format.html { redirect_to(@log_book, :notice => 'LogBook was successfully created.') }
        format.xml  { render :xml => @log_book, :status => :created, :location => @log_book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @log_book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /log_books/1
  # PUT /log_books/1.xml
  def update
    @log_book = LogBook.find(params[:id])

    respond_to do |format|
      if @log_book.update_attributes(params[:log_book])
        format.html { redirect_to(@log_book, :notice => 'LogBook was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @log_book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /log_books/1
  # DELETE /log_books/1.xml
  def destroy
    @log_book = LogBook.find(params[:id])
    @log_book.destroy

    respond_to do |format|
      format.html { redirect_to(log_books_url) }
      format.xml  { head :ok }
    end
  end
end
