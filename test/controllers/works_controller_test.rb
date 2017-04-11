require "test_helper"

describe WorksController do

  describe 'movies' do
    it 'gets the movies index page' do
      works = Work.all
      movies = works.where(category: "movie")
      movies.count.must_be :>, 0

      get movies_path
      must_respond_with :success
    end

    it 'is still successful when there are no movies' do
      Work.destroy_all
      get movies_path
      must_respond_with :success
    end
  end

  describe 'books' do
    it 'gets the books index page' do
      works = Work.all
      books = works.where(category: "book")
      books.count.must_be :>, 0

      get books_path
      must_respond_with :success
    end

    it 'is still successful when there are no books' do
      Work.destroy_all
      get books_path
      must_respond_with :success
    end
  end

  describe 'albums' do
    it 'gets the albums index page' do
      works = Work.all
      albums = works.where(category: "album")
      albums.count.must_be :>, 0

      get albums_path
      must_respond_with :success
    end

    it 'is still successful when there are no albums' do
      Work.destroy_all
      get albums_path
      must_respond_with :success
    end
  end

 describe 'show' do

   it 'should show a works page' do
     work_id = Work.first.id
     get work_path(work_id)
     must_respond_with :success
   end

  #  it 'returns a 404 if work DNE' do

  #  end
 end

 describe 'create' do

   it 'should create a work with good data' do
     movie_data = { category: "movie", title: "Bug's Life", creator: "Pixar", publication_year: "1997" }
     post works_path, params: { work: movie_data }
     must_respond_with :redirect
     must_redirect_to movies_path
   end

   it "re-renders a new form if passed invalid input" do
     movie_data = { category: "movie", creator: "Pixar", publication_year: "1997" }
     post works_path, params: { work: movie_data }
     must_respond_with :bad_request
   end
  end

  describe 'edit' do

    it 'should update an work with good input' do
      edited_info = { title: "New Title" }
      # you need an id for work_path... copying from curric
      put work_path(works(:nemo).id), params: { work: edited_info }

      work = Work.find_by(title: "New Title")
      # this example of finding object did not work
      # post = Post(posts(:one).id)

      work.title.must_equal "New Title"

      must_respond_with :redirect
    end

    # it "should update a post" do
    #   put post_path(posts(:one).id), params: {post: {title: "Some title goes here", description: "la la la"} }
    #
    #   # find the post with that ID in the database
    #   post = Post(posts(:one).id)
    #
    #
    #      # verify the post was changed properly
    #   post.title.must_equal "Some title goes here"
    #   post.description.must_equal "la la la"
    #
    #   must_respond_with :redirect
    # end

  end
end
