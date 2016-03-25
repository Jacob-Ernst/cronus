class GoalsController < ApplicationController

  # [POST] /users/goals
  def create
    params_for_save = goal_params
    params_for_save[:user] = @current_user
    goal = Goal.new params_for_save

    if goal.save
      goal.add_tags params[:tags]
      render json: goal.reload, status: 201
    else
      render json: { error: 'Could not create new goal' }, status: 409
    end
  end

  # [PUT] /goals/:id
  def update
    goal.attributes = goal_params

    if goal and goal.save
      render json: { message: 'Succesfully updated goal' }, status: 200
    else
      render json: { error: 'Unable to update goal' }, status: 422
    end
  end

  # DELETE /goals/:id
  def destroy
    if goal and goal.destroy
      render json: { message: 'Goal successfully deleted' }, status: 200
    elsif goal == nil
      render json: { message: 'Goal not found' }, status: 404
    else
      render json: { message: 'Unable to delete goal' }, status: 422
    end
  end

  # GET /goals/:id
  def show
    if goal and goal.user == @current_user
      render json: goal, status: 200
    elsif goal == nil
      render json: { message: 'Goal not found' }, status: 404
    else
      render json: { message: 'User unauthorized to view this goal' }, status: 403
    end
  end

  # [GET] /goals
  def index
    all_goals = Goal.where(user: @current_user)

    if params[:page]
      offset = (params[:page] - 1) * 10
    else
      offset = 0
    end

    goals = all_goals.offset(offset).limit(10)

    if !goals.empty?
      render json: goals, status: 200
    else
      render json: { message: "You haven't made any goals yet" }, status: 200
    end

  end

  # [PUT] goals/:id/tags
  def add_tags_to_goal
    if goal and goal.add_tags(params[:tags])
      render json: { message: 'Succesfully added tags to goal' }, status: 200
    elsif goal == nil
      render json: { message: 'Goal not found' }, status: 404
    else
      render json: { error: 'Unable to add tags to goal' }, status: 422
    end
  end

  # DELETE /goals/:id
  def remove_tags_from_goal
    if goal and remove_tags.add_tags(params[:tags])
      render json: { message: 'Succesfully removed tags from goal' }, status: 200
    elsif goal == nil
      render json: { message: 'Goal not found' }, status: 404
    else
      render json: { message: 'Unable to remove tags from goal' }, status: 422
    end
  end

  private

  def goal
    @goal = Goal.exists?(params[:id]) ? Goal.find(params[:id]) : nil
  end

  def goal_params
    params.require(:goal)
    .permit(:title,
            :description,
            :frequency,
            :deadline,
            :category,
            :target
          )
  end

end
