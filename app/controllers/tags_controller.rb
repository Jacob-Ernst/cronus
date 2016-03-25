class TagsController < ApplicationController
  # [GET] /tags
  def index
    if !tags.empty?
      render json: ActiveModel::ArraySerializer.new(tags, each_serializer: TagSerializer), status: 200
    else
      render json: { message: "You haven't added any tags yet" }, status: 200
    end
  end

  private

  def tags
    all_tags = Tag.joins(:goals).where(:goals => {:user => @current_user})

    if params[:page]
      offset = (params[] - 1) * 10
    else
      offset = 0
    end

    tags = all_tags.offset(offset).limit(10)
  end
end
