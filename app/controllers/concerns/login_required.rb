module LoginRequired
  extend ActiveSupport::Concern
  included do
    before_action :require_login

    def require_login
      return unless session[:user_id].nil?
      if request.xhr?
        render json: ['error_msg' => 'Please let other guys knows your nickname!'], status: :forbidden
      else
        flash[:error] = 'Please let other guys knows your nickname!'
        redirect_to root_path
      end
    end
  end
end