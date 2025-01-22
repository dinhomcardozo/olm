class Admin::SystemAdminsController < ApplicationController
    # before_action :authenticate_system_admin!
    # before_action :ensure_super_admin

    def ensure_super_admin
        unless current_system_admin.super_admin?
          redirect_to admin_clients_path, alert: 'Acesso negado.'
        end
    end
end