class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid


    def index 
        campers = Camper.all 
        render json: campers
    end
    def show 
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperActivitySerializer,
        status: :ok
    end 
    def create   
        camper = Camper.create!(create_camper_params)
        #bang! triggers error
        render json: camper, status: :created 
    end

    private  

    def create_camper_params 
        params.permit(:name, :age)
    end

    def record_invalid(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end 

    def record_not_found(exception) 
        render json: { error: "#{exception.model} not found" }, status: :not_found 
        
    end

end
