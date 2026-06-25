module ApplicationHelper
  def active_nav?(resource)
    controller_name == resource || controller_name.start_with?(resource) ? "active" : ""
  end

  STATUS_CONFIG = {
    "0" => { label: "Em Elaboração", css: "badge-elaboracao",  icon: "pencil-square" },
    "1" => { label: "Enviado",       css: "badge-enviado",     icon: "send" },
    "2" => { label: "Aprovado",      css: "badge-aprovado",    icon: "check-circle-fill" },
    "3" => { label: "Reprovado",     css: "badge-reprovado",   icon: "x-circle-fill" }
  }.freeze

  def status_badge(code)
    cfg = STATUS_CONFIG[code.to_s] || { label: "—", css: "badge-secondary", icon: "question-circle" }
    content_tag(:span, class: "status-badge #{cfg[:css]}") do
      content_tag(:i, "", class: "bi bi-#{cfg[:icon]}") +
        " #{cfg[:label]}"
    end
  end

  def status_label(code)
    STATUS_CONFIG.dig(code.to_s, :label) || "—"
  end

  def page_title(title)
    content_tag(:div, class: "page-header") do
      content_tag(:h1, title, class: "page-title")
    end
  end

  def empty_state(message, icon: "inbox")
    content_tag(:div, class: "empty-state") do
      content_tag(:i, "", class: "bi bi-#{icon}") +
        content_tag(:p, message)
    end
  end
end
