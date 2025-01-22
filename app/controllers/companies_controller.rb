class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all
    @companies = @companies.where("company_name LIKE ?", "%#{params[:search]}%") if params[:search].present?
    @companies = @companies.order(params[:order_by] || "company_name" => params[:direction] || "asc")
    @companies = @companies.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    @company.created_by = current_user # Ignorando a autenticação por enquanto

    if @company.save
      redirect_to @company, notice: 'Empresa criada com sucesso.'
    else
      render :new
    end
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Empresa atualizada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Empresa excluída com sucesso.'
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(
      :company_name, :company_cnpj, :email, :phone, :country, :zipcode, :address, :number, :neighborhood, 
      :city, :state, :group_id, :segment_id, :sub_segment_id, :contact_ids, :current_opportunities, :current_contracts
    )
  end
end