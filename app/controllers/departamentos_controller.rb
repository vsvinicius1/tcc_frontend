class DepartamentosController < ApplicationController
  def index
    @departamentos = ApiClient.departamentos || []

    if params[:search].present?
      termo = params[:search].downcase

      @departamentos = @departamentos.select do |depto|
        depto["nome"]&.downcase&.include?(termo) ||
        depto["sigla"]&.downcase&.include?(termo)
      end
    end

    @unidades_academicas = ApiClient.unidades_academicas || []
    @search = params[:search]
  end
end