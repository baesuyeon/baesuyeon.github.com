class LikesController < ApplicationController
    before_action :authenticate_user!
    
    def like_toggle
        like = Like.find_by(user_id: current_user.id, project_id: params[:project_id])
        
        one = params[:value1]
        two = params[:value2]
        three = params[:value3]
        four = params[:value4]
        five = params[:value5]
        six = params[:value6]
        
        if one.nil?
            one = "dfjkdlqjfdfa1"
        end
        
        if two.nil?
            two = "dfjkdlqjfdfa2"
        end
        
        if three.nil?
            three = "dfjkdlqjfdfa6"
        end
        
        if four.nil?
            four = "dfjkdlqjfdfa3"
        end
        
        if five.nil?
            five = "dfjkdlqjfdfa4"
        end
        
        if six.nil?
            six = "dfjkdlqjfdfa5"
        end
        
        if (one == two) || (one == three) || (one == four) || (one == five) || (one == six) || (two == three) || (two == four) || (two == five) || (two == six) || (three == four) || (three == five) || (three == six) || (four == five) || (four == six) || (five == six)
            flash[:fail] = "역할을 중복하여 선택하셨습니다."
            redirect_to "/projects/#{params[:project_id]}"
        else
        
            if like.nil?
                Like.create(user_id: current_user.id, project_id: params[:project_id], one: params[:value1], two: params[:value2], three: params[:value3], four: params[:value4], five: params[:value5], six: params[:value6])
            else
                like.destroy
            end
            
            redirect_to :back
        end
        
        
    end
end
