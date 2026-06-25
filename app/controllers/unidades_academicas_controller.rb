class UnidadesAcademicasController < ApplicationController
  def index
    @unidades_academicas = ApiClient.unidades_academicas || []

    if params[:search].present?
      termo = params[:search].downcase

      @unidades_academicas = @unidades_academicas.select do |ua|
        ua["nome"]&.downcase&.include?(termo) ||
        ua["sigla"]&.downcase&.include?(termo)
      end
    end

    @search = params[:search]
  end
end