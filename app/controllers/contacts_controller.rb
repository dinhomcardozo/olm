class ContactsController < ApplicationController
  def index
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
