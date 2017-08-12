class Admin::ApplicationController < ActionController::Base
  before_action :authenticate_admin_admin_user!
  layout 'admin/layouts/application'
end