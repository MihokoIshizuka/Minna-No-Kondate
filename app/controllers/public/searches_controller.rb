class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

  def search
    @range = params[:range]

    if @range == "会員"
      @members = Member.looks(params[:word])
    else
      @menus = Menu.looks(params[:word])
    end
  end

end
