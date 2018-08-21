class LikesController < ApplicationController
    before_action :authenticate_user!
    
    def like_toggle
        like = Like.find_by(user_id: current_user.id, project_id: params[:project_id])
        
        if like.nil?
            Like.create(user_id: current_user.id, project_id: params[:project_id], one: params[:value1], two: params[:value2], three: params[:value3], four: params[:value4], five: params[:value5], six: params[:value6], seven: params[:value7], eight: params[:value8])
        else
            like.destroy
        end
        
        redirect_to :back
    end
end
