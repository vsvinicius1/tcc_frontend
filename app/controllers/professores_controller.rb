class ProfessoresController < ApplicationController
  def index
    params_api = {}
    params_api[:search] = params[:search] if params[:search].present?
    @professores   = ApiClient.professores(params_api) || []
    @departamentos = ApiClient.departamentos || []
    @search        = params[:search]
  end
end
