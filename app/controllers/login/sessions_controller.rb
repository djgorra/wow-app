class Login::SessionsController < Devise::SessionsController
  respond_to :json 

  def destroy
    # Revoke JWT and run default logout action.
    token = request.headers['Authorization'].to_s.split('Bearer ').last
    revoke_token(token)
    # Delete Authorization header
    request.delete_header('Authorization')
    super
  end
    
    private  

    def revoke_token(token)
      # Decode JWT to get jti and exp values.
      secret = User.secret
      jti = JWT.decode(token, secret, true, algorithm: 'HS256', verify_jti: true)[0]['jti']
      exp = JWT.decode(token, secret, true, algorithm: 'HS256')[0]['exp']
      user_id = JWT.decode(token, secret, true, algorithm: 'HS256')[0]['id']
      # Add record to blacklist.
      sql_blacklist_jwt = "INSERT INTO jwt_denylist (jti, exp, id) VALUES ('#{ jti }', '#{ Time.at(exp) }', #{user_id});"
      ActiveRecord::Base.connection.execute(sql_blacklist_jwt)
    end
    
    def respond_with(resource, _opts = {})
      render :json=>resource, status: :ok
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