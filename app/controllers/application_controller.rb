class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
end

private
def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  # deviseは元々設定された絡む以外を受け付けないため、今回追加した
  # nameカラムを受け入れるためにストロングパラメーターを設定する
end
