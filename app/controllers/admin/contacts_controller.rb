class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!


  def show
    @member = Member.find(params[:member_id])
    @contacts = @member.contacts.all && current_admin.contacts.all
    @contact = Contact.new
  end

  def create
    @member = Member.find(params[:member_id])
    @contact = Contact.new(contact_params)
    @contact.admin_id = current_admin.id
    @contact.save
    redirect_to request.referer
    @contacts = @member.contacts.all && current_admin.contacts.all
  end

  def destroy
    @member = Member.find(params[:member_id])
    Contact.find(params[:id]).destroy
    redirect_to request.referer
    @contacts = @member.contacts.all && current_admin.contacts.all
  end

  private

  def contact_params
    params.require(:contact).permit(:message, :image, :admin_id)
  end
end
