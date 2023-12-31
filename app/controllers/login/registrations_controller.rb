class Login::RegistrationsController < Devise::RegistrationsController
    respond_to :json  
    
    private 

    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed
    end  

    def register_success
      render :json=>resource, status: :ok
    end  
    def register_failed
      render json: { message: resource.errors.full_messages.first }, status: :unauthorized
    end
end