require "test_helper"

describe UsersController do
  describe 'index' do

    it "gets the index page successfully" do
      User.count.must_be :>, 0
      get users_path
      must_respond_with :success
    end

    it 'still successful when there are no works' do
      User.destroy_all
      get users_path
      must_respond_with :success
    end
  end

  describe 'show' do

    it 'should show a users page' do
      id = User.first.id
      get user_path(id)
      must_respond_with :success
    end

    it 'returns a 404 if work DNE' do
      user = User.first
      id = user.id
      user.destroy
      get user_path(id)
      must_respond_with :not_found
    end
  end

  describe 'create' do

    it 'should create a new user with good data' do
      user_data = { username: "cynbin"}
      post users_path, params: { user: user_data }
      must_respond_with :success
      # must_respond_with :redirect
      # must_redirect_to user_path
    end

  end
  #
  # it "re-renders a new form if passed invalid data" do
  #   movie_data = { category: "movie", creator: "Pixar", publication_year: "1997" }
  #   post works_path, params: { work: movie_data }
  #   must_respond_with :bad_request
  # end
end