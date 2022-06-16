class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!


  def show
    @member = Member.find(params[:member_id])
    @contacts = @member.contacts
    @contact = Contact.new
  end

  def create
    @member = Member.find(params[:member_id])
    @contact = current_admin.contacts.new(contact_params)
    @contact.member_id = @member.id
    @contact.role = 'admin'
    @contact.save
    redirect_to request.referer
    @contacts = @member.contacts
  end

  def destroy
    @member = Member.find(params[:member_id])
    Contact.find(params[:id]).destroy
    redirect_to admin_member_contacts_path(@member)
    @contacts = @member.contacts
  end

  private

  def contact_params
    params.require(:contact).permit(:message, :image, :admin_id)
  end
end
