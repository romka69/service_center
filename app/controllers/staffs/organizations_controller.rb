class Staffs::OrganizationsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @organizations = Organization.all
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: @organization, status: :created
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @organization = Organization.find(params[:id])

    if @organization.destroy
      render json: @organization, status: :accepted
    else
      render json: @organization.errors, status: :unprocessable_entity
    end

  end

  private

  def organization_params
    params.permit(:name, :form_id, :inn, :ogrn)
  end
end
