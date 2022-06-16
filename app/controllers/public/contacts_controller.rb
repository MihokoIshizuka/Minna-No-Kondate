class Public::ContactsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_correct_member, only: [:show, :create]

  def show
    @contacts = current_member.contacts.all
    @contact = Contact.new
  end

  def create
    @contact = current_member.contacts.new(contact_params)
    @contact.admin_id = Admin.first.id
    @contact.source = 'member'
    @contact.save
    redirect_to request.referer
    # unless @contact.save
    #   render 'show', alert: "お問い合わせが送信できませんでした"
    # end
    @contacts = current_member.contacts.all
  end

  private

  def contact_params
    params.require(:contact).permit(:message, :image).merge(member_id: current_member.id)
  end

  def ensure_correct_member
    @member = Member.find(params[:member_id])
    unless @member.id == current_member.id
      redirect_to members_path
    end
  end

end
