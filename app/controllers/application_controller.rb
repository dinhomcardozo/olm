class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  helper_method :current_user
  # before_action :require_login, unless: :devise_controller? # Aplica o filtro apenas fora dos controladores do Devise
  allow_browser versions: :modern

  private
  
#   def require_login
#     unless current_user
#       # Evita redirecionar se já está na página de login
#       if request.path != new_user_session_path
#         redirect_to new_user_session_path, alert: "Você precisa estar logado para acessar esta página."
#       end
#     end
#   end

#   def check_login
#     unless current_user
#       redirect_to "http://localhost:3000/users/sign_in", alert: "Seja OLM! Faça seu login e começa a transformação contínua na Gestão do Ciclo de Vida de Oportunidades."
#     end
#   end
  
  def current_user
    # Substitua pela lógica de autenticação do seu sistema
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end