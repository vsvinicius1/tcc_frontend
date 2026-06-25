class ApiClient
  BASE_URL = ENV.fetch("API_BASE_URL", "http://127.0.0.1:8000/api/")

  # ─────────────────────────────────── Conexões ───────────────────────────────

  def self.json_conn
    Faraday.new(url: BASE_URL) do |f|
      f.request  :json
      f.response :json, content_type: /\bjson$/
      f.adapter  Faraday.default_adapter
    end
  end

  def self.multipart_conn
    Faraday.new(url: BASE_URL) do |f|
      f.request  :multipart
      f.request  :url_encoded
      f.response :json, content_type: /\bjson$/
      f.adapter  Faraday.default_adapter
    end
  end

  # ─────────────────────────────── Métodos genéricos ──────────────────────────

  def self.get(path, params = {})
    resp = json_conn.get(path, params)
    resp.body
  rescue Faraday::Error => e
    Rails.logger.error "[ApiClient] GET #{path} falhou: #{e.message}"
    nil
  end

  def self.post(path, body = {})
    resp = json_conn.post(path) do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = body.to_json
    end
    resp.body
  rescue Faraday::Error => e
    Rails.logger.error "[ApiClient] POST #{path} falhou: #{e.message}"
    nil
  end

  def self.post_multipart(path, params = {})
    resp = multipart_conn.post(path, params)
    resp.body
  rescue Faraday::Error => e
    Rails.logger.error "[ApiClient] POST multipart #{path} falhou: #{e.message}"
    nil
  end

  def self.patch(path, body = {})
    resp = json_conn.patch(path) do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = body.to_json
    end
    resp.body
  rescue Faraday::Error => e
    Rails.logger.error "[ApiClient] PATCH #{path} falhou: #{e.message}"
    nil
  end

  def self.patch_multipart(path, params = {})
    resp = multipart_conn.patch(path, params)
    resp.body
  rescue Faraday::Error => e
    Rails.logger.error "[ApiClient] PATCH multipart #{path} falhou: #{e.message}"
    nil
  end

  # ─────────────────────────────── Endpoints ──────────────────────────────────

  def self.unidades_academicas(params = {})
    Array(get("unidades-academicas/", params))
  end

  def self.departamentos(params = {})
    Array(get("departamentos/", params))
  end

  def self.cursos(params = {})
    Array(get("cursos/", params))
  end

  def self.alunos(params = {})
    Array(get("alunos/", params))
  end

  def self.professores(params = {})
    Array(get("professores/", params))
  end

  def self.tccs(params = {})
    Array(get("tccs/", params))
  end

  def self.tcc(id)
    get("tccs/#{id}/")
  end

  def self.estatisticas
    get("tccs/estatisticas/")
  end

  def self.criar_tcc(params)
    post_multipart("tccs/", params)
  end

  def self.atualizar_tcc(id, params)
    patch_multipart("tccs/#{id}/", params)
  end
end
