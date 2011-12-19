class Admin::RolesController < ApplicationController
  before_filter :require_admin

  def index
    @roles = Roles.all
  end

  def new
    @role = Role.new
    @nodes = Node.all
  end

  def create
    params[:role][:nodes_list] = params[:role][:nodes].reject {|key,value| value == "0" }.keys
    params[:role].delete(:nodes)
    @role = Role.create(params[:role])
    redirect_to role_path(@role)
  end

  def edit
    @role = Role.find(params[:id])
    @nodes = Node.all
  end

  def update
    @role = Role.find(params[:id])
    params[:role][:nodes_list] = params[:role][:nodes].reject {|key,value| value == "0" }.keys
    params[:role].delete(:nodes)
    @role.update_attributes(params[:role])
    redirect_to role_path(@role)
  end
end
