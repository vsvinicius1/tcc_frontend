class AlunosController < ApplicationController
  def index
    params_api = {}
    params_api[:search] = params[:search] if params[:search].present?
    @alunos  = ApiClient.alunos(params_api) || []
    @cursos  = ApiClient.cursos || []
    @search  = params[:search]
  end
end
