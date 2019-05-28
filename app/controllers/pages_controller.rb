class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  set_tab :dashboard

  def home
  end

  def dashboard
    @places = current_user.places
  end
end
