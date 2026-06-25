class DepartamentosController < ApplicationController
  def index
    params_api = {}
    params_api[:search] = params[:search] if params[:search].present?
    @departamentos          = ApiClient.departamentos(params_api) || []
    @unidades_academicas    = ApiClient.unidades_academicas || []
    @search                 = params[:search]
  end
end
