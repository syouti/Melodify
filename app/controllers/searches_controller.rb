class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model == 'user'
      @records = search_users
    elsif @model == 'post'
      @records = search_posts
    else
      @records = []
    end
  end

  private

  def search_users
    case @method
    when 'perfect'
      User.where(name: @content)
    when 'forward'
      User.where('name LIKE ?', "#{@content}%")
    when 'backward'
      User.where('name LIKE ?', "%#{@content}")
    when 'partial'
      User.where('name LIKE ?', "%#{@content}%")
    else
      User.none
    end
  end

  def search_posts
    case @method
    when 'perfect'
      Post.where(title: @content)
    when 'forward'
      Post.where('title LIKE ?', "#{@content}%")
    when 'backward'
      Post.where('title LIKE ?', "%#{@content}")
    when 'partial'
      Post.where('title LIKE ?', "%#{@content}%")
    else
      Post.none
    end
  end
end
