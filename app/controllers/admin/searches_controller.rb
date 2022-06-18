class Admin::SearchesController < ApplicationController
   before_action :authenticate_admin!

  def search
    word = params['word']
    @members = partial_member(word)
    @menus = partial_menu(word)
  end

  private
  # 会員の部分一致検索
  def partial_member(word)
    Member.where('name LIKE ?', "%#{word}%")
  end
  # 献立の部分一致検索
  def partial_menu(word)
    Menu.where('body LIKE ?', "%#{word}%")
  end
end
