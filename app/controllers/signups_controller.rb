class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :its_invalid

def create
    signup = Signup.create!(signup_params)
    render json: signup.activity, status: :created
 end

 private
   
 def signup_params
    params.permit(:camper_id, :activity_id, :time)
    end

    def its_invalid(invalid)
        render json: {"errors": ["validation errors"]}, status: :unprocessable_entity
    end

end
