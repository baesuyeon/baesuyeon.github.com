class ProjectsController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?

  # protected
  def welcom
    if user_signed_in?
      redirect_to "/projects"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mbti])
  end
  
  def index
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end
    
    @projects = Project.all
    @likes = Like.all
    
  end
  
  def profile
  end
  
  def new
  end
  
  def create
      @project = Project.new
      @project.name = params[:project_name]
      @project.content = params[:project_content]
      @project.deadline = params[:project_deadline]
      @project.numateam = params[:project_numofateam]
      #project.numjob = params[:project_numofjob]
      @project.user_id = params[:user_id]
      @project.image = params[:image]
      @project.state = 0
      
      @numberofjob = 0
      
      if params[:job1] != ""
        @numberofjob = @numberofjob + 1
      end
      
      if params[:job2] != ""
        @numberofjob = @numberofjob + 1
      end
      
      if params[:job3] != ""
        @numberofjob = @numberofjob + 1
      end
      
      if params[:job4] != ""
        @numberofjob = @numberofjob + 1
      end
      
      if params[:job5] != ""
        @numberofjob = @numberofjob + 1
      end
      
      if params[:job6] != ""
        @numberofjob = @numberofjob + 1
      end
      
      @project.numjob = @numberofjob
      @project.save
      
      for i in 1..@project.numjob
        job = Job.new
        if i == 1
          job.content = params[:job1]
        elsif i == 2
          job.content = params[:job2]
        elsif i == 3
          job.content = params[:job3]
        elsif i == 4
          job.content = params[:job4]
        elsif i == 5
          job.content = params[:job5]
        elsif i==6
          job.content = params[:job6]
        end
        job.project_id = @project.id
        
        job.save
      end
      
      redirect_to projects_path
  end
  
  def show
     @project = Project.find(params[:id])
     @jobs = Job.all
     @index = 0
     
     @likes = Like.all
     @users = User.all
     
     @numberofpeople = 0
  end
  
  def destroy
  end
  
  def teambuilding2
    @likes = Like.all
    @Users = User.all
    @Jobs = Job.all
    
    @current_project_id = params[:id]
    @current_project_id = @current_project_id.to_i
    
    @numperson = Project.find(params[:id]).numateam # 한팀당 몇명이 속하는지 
    @total = params[:total] # 총 인원
    @numberofgroup = (@total.to_i)/@numperson # 그룹의 갯수
    @numberofjob = Project.find(params[:id]).numjob # 역할의 갯수
    
    @arrs = Array.new(@total.to_i) { Array.new((@numberofjob).to_i + 1) }
    @wants = Array.new(@numberofjob.to_i, 0) { Array.new(@numberofjob.to_i, 0) }
    temp = Array.new(8, 0) { Array.new(1000, 0) }
    @job = Array.new(9, 1000) # 1부터 시작
    userid = Array.new(500, 0)
    index = 0
    
    @resulttemp = Array.new
    @results =Array.new(@numberofjob) { Array.new }
    
    @hash = Array.new(1000)
    
    
    @likes.each do |like| 
      like.project_id = like.project_id.to_i
      
      if like.project_id== @current_project_id
        @arrs[index][0] =  like.user_id.to_i
        @hash[like.user_id.to_i] = index
         
        for j in 1..(@numberofjob).to_i do
          if j == 1
            if index == 0
              @job[j] = like.one.to_i
            end
            
            @arrs[index][j] = like.one.to_i
            temp[0][like.one.to_i] = temp[0][like.one.to_i] + 1
          elsif j == 2
            if index == 0
              @job[j] = like.two.to_i
            end
            
            @arrs[index][j] = like.two.to_i
            temp[1][like.two.to_i] = temp[1][like.two.to_i] + 1
          elsif j == 3
            if index == 0
                @job[j] = like.three.to_i
            end
          
            @arrs[index][j] = like.three.to_i
            temp[2][like.three.to_i] = temp[2][like.three.to_i] + 1
          elsif j == 4
            if index == 0
                @job[j] = like.four.to_i
            end
            
            @arrs[index][j] = like.four.to_i
            temp[3][like.four.to_i] = temp[3][like.four.to_i] + 1
          elsif j == 5
            if index == 0
                @job[j] = like.five.to_i
            end
          
            @arrs[index][j] = like.five.to_i
            temp[4][like.five.to_i] = temp[4][like.five.to_i] + 1
          elsif j == 6
            if index == 0
                @job[j] = like.six.to_i
            end
          
            @arrs[index][j] = like.six.to_i
            temp[5][like.six.to_i] = temp[5][like.six.to_i] + 1
          # elsif j == 7
          #   if index == 0
          #       @job[j] = like.seven.to_i
          #   end
            
          #   @arrs[index][j] = like.seven.to_i
          #   temp[6][like.seven.to_i] = temp[6][like.seven.to_i] + 1
          # elsif j == 8
          #   if index == 0
          #       @job[j] = like.eight.to_i
          #   end
          
          #   @arrs[index][j] = like.eight.to_i
          #   temp[7][like.eight.to_i] = temp[7][like.eight.to_i] + 1
          end
        end
        
        index = index + 1
      end
    end 
    
    @job = @job.sort
    
    for i in 0..(@numberofjob.to_i)-1 do
        for j in 0..(@numberofjob.to_i)-1 do
              @wants[i][j] = temp[j][@job[i]];
        end
    end
    
    # arrs 출력해보기
    # for i in 0..(@arrs.size-1) do 
    #   for j in 0..(@numberofjob.to_i) do
    #     print @arrs[i][j]
    #   end
    #   puts
    # end
    
    
    x = 0
    y = 0

    for i in 0..(@numberofjob.to_i)-1 do
        min = 1000
        for j in 0..(@numberofjob.to_i)-1 do
            if @wants[j][0] < min and @wants[j][0]!=0
              min = @wants[j][0]
              x = j
              y = i
            end
        end
        
        #임시
        puts "wants"
        for p in 0..2 do
          for u in 0..2 do
            puts @wants[p][u] 
          end
          
        end
        
        puts "x" , x
        puts "y" , y
        
        assign = 0
        
        for q in 0 .. (@numberofjob.to_i) do
          if assign >= min or assign >= @numberofgroup.to_i
            break
          end
             
          for j in 0..(@arrs.size-1) do
            if assign >= min or assign >= @numberofgroup.to_i
              break
            end
            
            if @arrs[j][q+1] == @job[x] and userid[@arrs[j][0]] == 0
              @results[x].push(@arrs[j][0])
              assign = assign + 1
              userid[@arrs[j][0]] = 1
              @wants[x][0] = @wants[x][0] - 1
              puts "가로줄은 ", x 
              puts @arrs[j][0] , "들어가뮤"
            end
          end
        end
          
        puts "ASSIGN: ", assign
        
        if assign < @numberofgroup.to_i
          mytemp = Array.new
          myhash = Array.new(300, 0)
          chi = @numberofgroup.to_i - assign
          puts "current_assign: ", assign 
    
            for k in (y+2).. 8 do
                if mytemp.size >= chi
                  break
                end
                
                for j in 0..(@arrs.size)-1 do
                    if userid[@arrs[j][0]] == 0 and @arrs[j][k] == @job[x]
                         mytemp.push(@arrs[j][0]) 
                         myhash[@arrs[j][0]] = @arrs[j][k]
                         puts @arrs[j][0] , "my temp에 들어가뮤우"
                    end
                end
            end  # temp에 user_id 다 뽑아놨고
    
            puts "mytemp_origin: ", mytemp
            mytemp = mytemp.sample(@numberofgroup.to_i - assign).sort
            puts "selected_mytemp: ", mytemp
    
            puts "chi: ", chi
            for a in 0..chi-1 do
                  @results[x].push(mytemp[a])
                  assign = assign + 1
                  userid[mytemp[a]] = 1
                  puts "temp값 넣는다."
                  puts mytemp[a] , "들어감"
                  
                  puts "확인해보기"
                  puts "a", a
                  puts "mytemp[a]", mytemp[a]
                  puts "@hash[mytemp[a]]", @hash[mytemp[a]]
                  puts "@arrs[@hash[mytemp[a]]][1]", @arrs[@hash[mytemp[a]]][1]
                  
                  @wants[ @arrs[@hash[mytemp[a]]][1] - @job[0] ] [0] = @wants[ @arrs[@hash[mytemp[a]]][1] - @job[0] ] [0] - 1
            end
        end
    end
    
    
    
    #나머지 배정
    last = 0
    for i in 0..@total.to_i-1 do
      if last == @total.to_i % @numperson.to_i
         break
      end
      
      if userid[@arrs[i][0]] == 0
            puts "얘: ", @arrs[i][0]
            @resulttemp.push(@arrs[i][0])
            userid[@arrs[i][0]] = 1
            last = last + 1
      end
    end

    puts "END"

    for i in 0..(@numberofjob)-1 do
      @results[i] = @results[i].shuffle
    end
    @resulttemp.shuffle
    

  end
  
  
  
  def completebuilding
    @current_project_id = params[:id]
    
    @likes = Like.all
    @Users = User.all
    @Jobs = Job.all
    
    @results = params[:results]
    
    
    @numberofgroup = params[:numberofgroup]
    @numberofjob = params[:numberofjob]
    
    @results = @results.gsub('[', '')
    @results = @results.gsub(']', '')
    @results = @results.gsub(' ', '')
    @results = @results.split(',')
    
    # redirect_to '#'
  end
  
  
  
  private
  def project_params
    params.require(:project).permit(:name, :content, :deadline, :numateam, :numjob, :user_id, :state, :image)
  end
  
  
  #만족도 평가 페이지

  def evaluation
    
  end
  
  
  def check
  end
  

end
