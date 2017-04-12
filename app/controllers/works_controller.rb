class WorksController < ApplicationController

  def index
    @works = Work.all
  end

  def movies
    @movies = find_movies
  end

  def books
    @books = find_books
  end

  def albums
    @albums = find_albums
  end

  def new_movie
    @work = Work.new
    @work.category = "movie"
    render "works/movies/new"
  end

  def new_book
    @work = Work.new
    @work.category = "book"
    render "works/books/new"
  end

  def new_album
    @work = Work.new
    @work.category = "album"
    render "works/albums/new"
  end

  def create
    @work = Work.new(works_params)

    if @work.save # is true - IE validations pass
      flash[:success] = "Added #{@work.title} Successfully"
      redirect_to find_path(@work)
    else # We know the validations didn't pass so want to show messages
      flash.now[:failure] = "Error: Item was not added"
      if @work.category == "movie"
        render "works/movies/new", status: :bad_request
      elsif @work.category == "book"
        render "works/books/new", status: :bad_request
      elsif @work.category == "album"
        render "works/albums/new", status: :bad_request
      end
    end
  end

  def show
    @work = find_work
  end

  def edit
    @work = find_work
  end

  def update
    @work = find_work
    @work.update_attributes(works_params)

    redirect_to work_path(@work.id)
  end

  def destroy
    work = find_work
    path = find_path(work)
    work.destroy
    redirect_to path
  end

private
  def works_params
    return params.required(:work).permit(:category,
                                         :title,
                                         :creator,
                                         :publication_year,
                                         :description)
  end

  def find_work
    Work.find(params[:id])
  end

  def find_movies
    Work.all.where(category: "movie")
  end

  def find_books
    Work.all.where(category: "book")
  end

  def find_albums
    Work.all.where(category: "album")
  end

  def find_path(work)
    if work.category == "movie"
      return movies_path
    elsif work.category == "book"
      return books_path
    elsif work.category == "album"
      return albums_path
    end
  end

end
