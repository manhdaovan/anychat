module BeforeActionTrigger
  extend ActiveSupport::Concern
  included do

    def require_login
      store_user_info(session[:username]) && return unless session[:username].nil?
      if request.xhr?
        render json: ['error_msg' => 'Please let other guys knows your nickname!'], status: :forbidden
      else
        flash[:error] = 'Please let other guys knows your nickname!'
        redirect_to root_path
      end
    end

    def store_next_url
      session[:forward_url] = request.path if request.get?
    end
  end
end