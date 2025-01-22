class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.all.includes(:company, :contact, :client_products, :stage)

    # Filtros por Produto
    if params[:product_type].present?
      @opportunities = @opportunities.joins(:client_products).where(client_products: { product_type: params[:product_type] })
    end

    if params[:product_description].present?
      @opportunities = @opportunities.joins(:client_products).where("LOWER(client_products.product_description) LIKE ?", "%#{params[:product_description].to_s.downcase}%")
    end

    if params[:product_brand].present?
      @opportunities = @opportunities.joins(:client_products).where(client_products: { product_brand: params[:product_brand] })
    end

    # Filtros por Estágio
    @opportunities = @opportunities.where(stage_id: params[:stage_ids]) if params[:stage_ids].present?

    # Filtros por Empresa
    if params[:company_name].present?
      @opportunities = @opportunities.joins(:company).where("LOWER(companies.company_name) LIKE ?", "%#{params[:company_name].to_s.downcase}%")
    end

    if params[:company_cnpj].present?
      clean_cnpj = params[:company_cnpj].to_s.gsub(/\D/, '')
      @opportunities = @opportunities.joins(:company).where("REPLACE(REPLACE(REPLACE(companies.company_cnpj, '.', ''), '-', ''), '/', '') LIKE ?", "%#{clean_cnpj}%")
    end

    # Filtros por Contato
    @opportunities = @opportunities.where(contact_id: params[:contact_id]) if params[:contact_id].present?

    if params[:contact_email].present?
      @opportunities = @opportunities.joins(:contact).where("LOWER(contacts.email) LIKE ?", "%#{params[:contact_email].to_s.downcase}%")
    end

    if params[:contact_name].present?
      @opportunities = @opportunities.joins(:contact).where("LOWER(CONCAT(contacts.first_name, ' ', contacts.last_name)) LIKE ?", "%#{params[:contact_name].to_s.downcase}%")
    end

    respond_to do |format|
      format.turbo_stream # Responder com Turbo Streams para atualizações dinâmicas
      format.html         # Caso a requisição não seja remota
    end
  end

  def new
    @opportunity = Opportunity.new
    @client_products = ClientProduct.all
  end

  def create
    @opportunity = Opportunity.new(opportunity_params)
    if @opportunity.save
      redirect_to @opportunity, notice: 'Oportunidade criada com sucesso!'
    else
      render :new
    end
    @client_products = ClientProduct.all
  end

  def show
    @opportunity = Opportunity.find(params[:id])
    respond_to do |format|
      format.html # Renderiza a página normal (se necessário)
      format.js   # Renderiza o JavaScript para carregar o lightbox
    end
    @client_products = ClientProduct.all
  end

  def edit
    @opportunity = Opportunity.find(params[:id])
    @client_products = ClientProduct.all
  end

  def update
    @opportunity = Opportunity.find(params[:id])
    if @opportunity.update(opportunity_params)
      redirect_to @opportunity, notice: 'Oportunidade atualizada com sucesso!'
    else
      render :edit
    end
    @client_products = ClientProduct.all
  end

  private

  def opportunity_params
    params.require(:opportunity).permit(
  :name, 
  :company_id, 
  :contact_id, 
  :group_id, 
  :email, 
  :phone, 
  :notes, 
  :segments, # Adicionado aqui, fora do hash aninhado
  products_attributes: [
    :product_id, 
    :product_description, 
    :quantity, 
    :unit_price, 
    :total_price
  ]
)
  end
end