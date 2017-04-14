require "test_helper"

describe WorksController do

  describe 'index' do

    it "gets the index page successfully" do
      Work.count.must_be :>, 0
      get homepage_path
      must_respond_with :success
    end

    it 'still successful when there are no works' do
      Work.destroy_all
      get homepage_path
      must_respond_with :success
    end
  end

  describe 'movies' do
    it 'gets the movies page' do
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
    it 'gets the books page' do
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
    it 'gets the albums page' do
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

  ###### AHHH - You don't have tests for new ###########
  describe 'new' do

  end

  describe 'create' do

    it 'should create a work with good data' do
      movie_data = { category: "movie", title: "Bug's Life", creator: "Pixar", publication_year: "1997" }

      # post works_path, params: { work: movie_data }
      # should test that the work was created
      # Work.find_by(title: "Bug's Life").wont_be_nil
      # could also check that the count when up but checking count before and after

      # coping the destory test pattern
      proc { post works_path, params: { work: movie_data } }.must_change 'Work.count', +1

      # double up and make sure the work is the db
      work = Work.last
      work.title.must_equal movie_data[:title]

      must_respond_with :redirect
      must_redirect_to movies_path
    end

    it "wont create a form and re-renders a new form if passed invalid data" do
      movie_data = { category: "movie", creator: "Pixar", publication_year: "1997" }
      start_count = Work.count
      post works_path, params: { work: movie_data }
      end_count = Work.count
      start_count.must_equal end_count
      must_respond_with :bad_request
    end
   end

 describe 'show' do

   it 'should show a works page' do
     work_id = Work.first.id
     get work_path(work_id)
     must_respond_with :success
   end

   it 'returns a 404 if work DNE' do
     work = Work.first
     id = work.id
     work.destroy
     get work_path(id)
     must_respond_with :not_found
   end
 end

 describe 'edit' do
   it 'shows you an edit page/form' do
     work_id = Work.first.id
     get edit_work_path(work_id)
     must_respond_with :success
   end

   it 'returns 404 if work DNE and you try to edit it' do
     work = Work.first
     id = work.id
     work.destroy
     get edit_work_path(id)
     must_respond_with :not_found
   end
 end

  describe 'update' do

    it 'should update a work' do
      put work_path(works(:nemo).id), params: { work: {title: "new title"}}
      work = Work.find(works(:nemo).id)
      work.title.must_equal "new title"
      work.title.wont_equal "Finding Nemo"
      must_respond_with :redirect
    end

    it 'return 404 if work DNE' do
      work = works(:nemo)
      work.destroy
      put work_path(work.id)
      must_respond_with :not_found
    end

    it 'does not update if new info is bad' do
      put work_path(works(:nemo).id), params: { work: {title: ""} }
      must_respond_with :bad_request
    end
  end

  describe 'destory' do

    it 'should delete a work' do
      proc { delete work_path(works(:nemo).id) }.must_change 'Work.count', -1
      must_respond_with :redirect
      must_redirect_to movies_path
    end

    # do I need this? - Oh would this ever come up?
    it 'return 404 if work DNE and you try to destory' do
      id = Work.last.id
      id += 1
      delete work_path(id)
      must_respond_with :not_found
    end
  end

  describe 'vote' do
    it 'should create a vote and redirect to work_path' do
      work_id = Work.first.id
      user_id = User.first.id
      controller.session[:user_id] = user_id
      # this test says vote is not getting created
      puts "Before: #{Vote.count}"
      post vote_path(work_id)
      puts "After: #{Vote.count}"
      must_respond_with :redirect
      must_redirect_to work_path(work_id)
    end

    it 'should not add a vote if user has already voted for that work' do

    end
  end
end
