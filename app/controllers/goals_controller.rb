class GoalsController < ApplicationController

  # [POST] /users/goals
  def create
    params_for_save = goal_params
    params_for_save[:user] = @current_user
    goal = Goal.new params_for_save

    if goal.save
      render json: goal.reload, status: 201
    else
      render json: { error: 'Could not create new goal' }, status: 409
    end
  end

  # [PUT] /users/goals
  def update
    goal = Goal.find goal_params[:id]

    goal.attributes = goal_params

    if goal.save
      render json: { message: 'Succesfully updated goal' }, status: 200
    else
      render json: { error: 'Unable to update goal' }, status: 422
    end
  end

  # DELETE /goals/:id
  def destroy
    goal = Goal.find params[:id]

    if goal.destroy
      render json: { message: 'Goal successfully deleted' }, status: 200
    else
      render json: { message: 'Unable to delete goal' }, status: 422
    end
  end

  # GET /goals/:id
  def show
    goal = Goal.find params[:id]

    if goal.user == @current_user
      render json: goal, status: 200
    else
      render json: { message: 'User unauthorized to view this goal' }, status: 403
    end
  end

  # [GET] /goals
  def index
    all_goals = Goal.where(user: @current_user)

    if params[:page]
      offset = (params[] - 1) * 10
    else
      offset = 0
    end

    goals = all_goals.offset(offset).limit(10)

    render json: goals, status: 200
  end

  private

  def goal_params
    params.require(:goal)
    .permit(:id,
            :title,
            :description,
            :frequency,
            :deadline,
            :category,
            :target
          )
  end

end
