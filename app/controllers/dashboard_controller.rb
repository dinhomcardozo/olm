class DashboardController < ApplicationController
  # before_action :authenticate_user!
  # before_action :check_login
  # before_action :require_login
  
  def index
    @stages = Stage.includes(opportunities: [:company, :contact, :opportunity_products]).map do |stage|
      {
        name: stage.stage_name,
        opportunities: stage.opportunities.map do |opportunity|
          # Você pode manipular as oportunidades diretamente sem a necessidade de passar um hash
          total_product_price = opportunity.opportunity_products.sum { |op| op.client_product.product_price }
          
          # Passando a instância do opportunity diretamente, sem usar merge ou modificações desnecessárias
          opportunity.define_singleton_method(:total_product_price) { total_product_price }
          opportunity
        end
      }
    end
    @opportunity = Opportunity.new # Cria um novo objeto Opportunity para o lightbox
    @opportunities = Opportunity.includes(:company, :contact, :opportunity_products).all #declarando para visualização de todas as oportunidades
    @client_products = ClientProduct.all
    Rails.logger.info "Client Products: #{@client_products.inspect}"
  end

  # Outros métodos permanecem sem alteração
  def show
    @client_products = ClientProduct.all
  end

  def destroy
  end

  def edit
    @client_products = ClientProduct.all
  end

  def update
    @client_products = ClientProduct.all
  end

  def create
    @client_products = ClientProduct.all
  end

  private

  def check_login
    unless current_user
      redirect_to "http://localhost:3000/users/sign_in", alert: "Você precisa estar logado para acessar esta página."
    end
  end
end