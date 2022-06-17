class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # admin/contacts/indexで会員がお問い合わせチャットを管理者へ送信した順に並べたい
    @members = Member.all.order(created_at: :desc).page(params[:page]).per(10)
    # @contact = Contact.new
    # @contact.source = 'member'
  end

  def show
    @member = Member.find(params[:member_id])
    @contacts = @member.contacts
    @contact = Contact.new
  end

  def create
    @member = Member.find(params[:member_id])
    @contact = current_admin.contacts.new(contact_params)
    @contact.member_id = @member.id
    @contact.source = 'admin'
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
