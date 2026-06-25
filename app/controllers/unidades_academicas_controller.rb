class UnidadesAcademicasController < ApplicationController
  def index
    params_api = {}
    params_api[:search] = params[:search] if params[:search].present?
    @unidades_academicas = ApiClient.unidades_academicas(params_api) || []
    @search              = params[:search]
  end
end
