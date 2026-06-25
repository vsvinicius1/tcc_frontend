class CursosController < ApplicationController
  def index
    @cursos = ApiClient.cursos || []

    if params[:search].present?
      termo = params[:search].downcase

      @cursos = @cursos.select do |curso|
        curso["nome"]&.downcase&.include?(termo) ||
        curso["sigla"]&.downcase&.include?(termo)
      end
    end

    @departamentos = ApiClient.departamentos || []
    @search = params[:search]
  end
end