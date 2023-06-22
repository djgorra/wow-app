class Login::SessionsController < Devise::SessionsController
  respond_to :json 
    
    private  
    
    def respond_with(resource, _opts = {})
      render json: { 
        access_token: request.headers["warden-jwt_auth.token"],
        token_type: "Bearer",
        expires_in: 3600,
        user: {
          "name": resource.username,
          "email": resource.email
        } 
      }, status: :ok
    end  
    
    def respond_to_on_destroy
      current_user ? log_out_success : log_out_failure
    end  
    
    def log_out_success
      render json: { message: "Logged out." }, status: :ok
    end  
    
    def log_out_failure
      render json: { message: "Logged out failure."}, status: :unauthorized
    end
end