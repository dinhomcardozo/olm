# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  def cancel
    super
  end

  protected

  # Permite parâmetros extras durante o registro
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])  # Adicione aqui os campos extras, se necessário
  end

  # Permite parâmetros extras durante a atualização da conta
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])  # Adicione aqui os campos extras, se necessário
  end

  # O caminho usado após o registro
  def after_sign_up_path_for(resource)
    super(resource)  # Por padrão, redireciona para a página principal após o registro
    # Se desejar redirecionar para outra página após o registro, use algo como:
    # redirect_to some_path
  end

  # O caminho usado após o registro para contas inativas
  def after_inactive_sign_up_path_for(resource)
    super(resource)  # Pode customizar se desejar
  end
end