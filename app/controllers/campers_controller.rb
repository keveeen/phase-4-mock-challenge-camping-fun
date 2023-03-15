class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :val_error
    rescue_from ActiveRecord::RecordNotFound, with: :did_not_find

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperWithActivitiesSerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def val_error(invalid)
        render json: {"errors": ["validation errors"]}, status: :unprocessable_entity
    end

    def did_not_find
        render json: {"error": "Camper not found"}, status: :not_found
    end

end
