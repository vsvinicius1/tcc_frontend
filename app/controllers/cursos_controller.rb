class CursosController < ApplicationController
  def index
    params_api = {}
    params_api[:search] = params[:search] if params[:search].present?
    @cursos        = ApiClient.cursos(params_api) || []
    @departamentos = ApiClient.departamentos || []
    @search        = params[:search]
  end
end
