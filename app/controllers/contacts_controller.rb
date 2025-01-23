class ContactsController < ApplicationController
  def index
    @contacts = Contact.all # Inicialize @contacts com todos os registros  

      # Busca por full_name
    if params[:search].present?
      @contacts = @contacts.where("CONCAT(first_name, ' ', last_name) ILIKE ?", "%#{params[:search]}%")
    end

    # Ordenação por full_name
    if params[:order_by] == "full_name"
      @contacts = @contacts.order("CONCAT(first_name, ' ', last_name) #{params[:direction] || 'ASC'}")
    else
      @contacts = @contacts.order("created_at DESC") # Ordenação padrão
    end

    # Paginação
    @contacts = @contacts.page(params[:page]).per(10)

  end

  def search
    query = params[:query]
    if query.present?
      # Busca por nome, sobrenome ou e-mail
      contacts = Contact.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", 
                               "%#{query}%", "%#{query}%", "%#{query}%")
      render json: contacts.map { |contact| 
        {
          contact_id: contact.id,
          first_name: contact.first_name,
          last_name: contact.last_name,
          email: contact.email,
          company_name: contact.company&.name,
          group_name: contact.group&.name,
          segments: contact.segments.pluck(:name).join(", "),
          telephone: contact.phone
        }
      }
    else
      render json: []
    end
  end 

  def new
    @contact = Contact.new
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def update
  end

  def create
  end
end
