class HomeController < ApplicationController
  # authorize_resource
  def game
  	@threeCandidates = Candidate.all.sample(3)
  	@quote = Candidate.getQuote(@threeCandidates.sample)
  end

  def exploreIssues
  end

  def manageLikedQuotes
  end

  def checkAnswer
  	@correct = params[:user_answer_id] != params[:correct_answer_id]
  	if @correct
  		@response = Candidate.getCorrectMessage(params[:correct_answer_id])
  	else
  		@response = "Correct!"
  		if logged_in?
	  		current_user.current_streak += 1
	  		current_user.save!
	  	end
  	end
  	redirect_to game_path, notice: @response, correct: @correct
  end
end
