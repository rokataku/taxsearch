class UsersController < ApplicationController
  def show
    @name = current_user.name
    @posts = current_user.posts.order(id: "DESC")
  end
end
