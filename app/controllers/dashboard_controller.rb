class DashboardController < ApplicationController
  def index
    @stats = ApiClient.estatisticas || {}
    @total_geral    = @stats["total_geral"] || 0
    @por_status     = @stats["por_status"] || {}
    @por_orientador = @stats["por_orientador"] || {}

    # Últimos 5 TCCs para a tabela rápida
    @ultimos_tccs = ApiClient.tccs.first(5)
  end
end
