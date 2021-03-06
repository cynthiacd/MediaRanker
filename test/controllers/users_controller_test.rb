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
      User.find_by(username: "cynbin").must_be_instance_of User
      must_respond_with :success
    end

    it 'should not create a new user if given bad data - IE no data' do
      post users_path, params: { user: { username: ""} }
      User.find_by(username: "").must_be_nil
    end
  end
end
