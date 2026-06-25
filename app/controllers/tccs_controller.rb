class TccsController < ApplicationController
  def index
    params_api = {}
    params_api[:search]  = params[:search]  if params[:search].present?
    params_api[:status]  = params[:status]  if params[:status].present?

    @tccs   = ApiClient.tccs(params_api) || []
    @search = params[:search]
    @status_filtro = params[:status]
    
    # Filtrar por status localmente
    if @status_filtro.present?
      @tccs = @tccs.select { |tcc| tcc["status"].to_s == @status_filtro.to_s }
    end
  end

  def new
    @alunos     = ApiClient.alunos     || []
    @professores = ApiClient.professores || []
    @cursos     = ApiClient.cursos     || []
  end

  def create
    arquivo = params[:arquivo]
    payload = {
      titulo:         params[:titulo],
      resumo:         params[:resumo],
      aluno:          params[:aluno_id],
      orientador:     params[:orientador_id],
      curso:          params[:curso_id],
      status:         params[:status] || "0",
      data_entrega:   params[:data_entrega],
      palavras_chave:   params[:palavras_chave],
      tipo:             params[:tipo],
      idioma:           params[:idioma],
      presidente:       params[:presidente_id],
      primeiro_membro:  params[:primeiro_membro_id],
      segundo_membro:   params[:segundo_membro_id]
    }

    if arquivo.present?
      payload[:arquivo] = Faraday::FilePart.new(
        arquivo.tempfile,
        arquivo.content_type,
        arquivo.original_filename
      )
    end

    resultado = ApiClient.criar_tcc(payload)

    if resultado && !resultado["id"].nil?
      redirect_to tccs_path, notice: "TCC cadastrado com sucesso!"
    else
      @alunos      = ApiClient.alunos      || []
      @professores = ApiClient.professores || []
      @cursos      = ApiClient.cursos      || []
      @erros       = resultado || {}
      flash.now[:alert] = "Erro ao cadastrar TCC. Verifique os campos."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tcc         = ApiClient.tcc(params[:id]) || {}
    @alunos      = ApiClient.alunos      || []
    @professores = ApiClient.professores || []
    @cursos      = ApiClient.cursos      || []
  end

  def update
    arquivo = params[:arquivo]
    payload = {
      titulo:       params[:titulo],
      resumo:       params[:resumo],
      aluno:        params[:aluno_id],
      orientador:   params[:orientador_id],
      curso:        params[:curso_id],
      status:       params[:status],
      data_entrega: params[:data_entrega]
    }

    if arquivo.present?
      payload[:arquivo] = Faraday::FilePart.new(
        arquivo.tempfile,
        arquivo.content_type,
        arquivo.original_filename
      )
    end

    resultado = ApiClient.atualizar_tcc(params[:id], payload)

    if resultado && !resultado["id"].nil?
      redirect_to tccs_path, notice: "TCC atualizado com sucesso!"
    else
      @tcc         = ApiClient.tcc(params[:id]) || {}
      @alunos      = ApiClient.alunos      || []
      @professores = ApiClient.professores || []
      @cursos      = ApiClient.cursos      || []
      @erros       = resultado || {}
      flash.now[:alert] = "Erro ao atualizar TCC."
      render :edit, status: :unprocessable_entity
    end
  end
end
