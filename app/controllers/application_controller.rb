class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Constantes de status (espelham o backend)
  STATUS_MAP = {
    "0" => { label: "Em Elaboração", css: "status-elaboracao" },
    "1" => { label: "Enviado",       css: "status-enviado" },
    "2" => { label: "Aprovado",      css: "status-aprovado" },
    "3" => { label: "Reprovado",     css: "status-reprovado" }
  }.freeze
  helper_method :STATUS_MAP
end
