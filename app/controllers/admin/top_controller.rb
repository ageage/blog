class Admin::TopController < Admin::ApplicationController
  before_action :authenticate_admin_admin_user!, only: :index

  def index
  end

  def authentication

  end
end