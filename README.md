# GestãoTCC — Frontend Ruby on Rails

Frontend em **Ruby on Rails** para o sistema de gerenciamento de TCCs, consumindo a API REST desenvolvida em Django REST Framework.

---

## Funcionalidades

| Módulo | Funcionalidade |
|---|---|
| 📊 Dashboard | Gráficos de TCCs por status (donut) e por orientador (barra) via Chart.js |
| 📄 TCCs | Listagem com busca por texto e filtro por status, cadastro com upload de PDF, edição completa e troca de status |
| 👤 Alunos | Listagem e busca com avatar inicial |
| 👨‍🏫 Professores | Listagem e busca com titulação |
| 📚 Cursos | Listagem e busca |
| 🏛️ Departamentos | Listagem e busca |
| 🏫 Unidades Acadêmicas | Listagem e busca |

---

## Pré-requisitos

- **Ruby** >= 3.1
- **Bundler** (`gem install bundler`)
- Backend Django rodando em `http://127.0.0.1:8000`

---

## Instalação e Execução

```bash
# 1. Clone o repositório
git clone <url-do-repositorio>
cd tcc_frontend

# 2. Instale as dependências
bundle install

# 3. Certifique que o backend Django está rodando
#    http://127.0.0.1:8000/api/

# 4. Inicie o servidor Rails
rails server
#   ou  bin/rails server

# 5. Acesse no navegador
#    http://localhost:3000
```
```
## Estrutura do Projeto

```
tcc_frontend/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb     # Base + constantes de status
│   │   ├── dashboard_controller.rb       # Dashboard c/ estatísticas
│   │   ├── tccs_controller.rb            # CRUD de TCCs + upload PDF
│   │   ├── alunos_controller.rb
│   │   ├── professores_controller.rb
│   │   ├── cursos_controller.rb
│   │   ├── departamentos_controller.rb
│   │   └── unidades_academicas_controller.rb
│   ├── services/
│   │   └── api_client.rb                 # Wrapper Faraday para o backend
│   ├── helpers/
│   │   └── application_helper.rb         # status_badge, active_nav?, etc.
│   └── views/
│       ├── layouts/application.html.erb  # Layout c/ sidebar + topbar
│       ├── dashboard/index.html.erb      # Gráficos Chart.js
│       ├── tccs/{index,new,edit}.html.erb
│       ├── alunos/index.html.erb
│       ├── professores/index.html.erb
│       ├── cursos/index.html.erb
│       ├── departamentos/index.html.erb
│       └── unidades_academicas/index.html.erb
├── config/
│   ├── routes.rb
│   ├── application.rb
│   └── environments/
├── Gemfile
└── README.md
```

---

## Dependências Principais

| Gem | Uso |
|---|---|
| `rails ~> 7.1` | Framework web |
| `faraday ~> 2.7` | Cliente HTTP para consumir a API |
| `faraday-multipart ~> 1.0` | Upload de arquivos PDF via multipart/form-data |
| `puma` | Servidor web |

**CDNs (sem instalação):**
- Bootstrap 5.3 + Bootstrap Icons
- Chart.js 4.4
- Google Fonts (Inter)

---

## Mapeamento de Status

| Código | Rótulo | Cor |
|---|---|---|
| `0` | Em Elaboração | Azul |
| `1` | Enviado | Âmbar |
| `2` | Aprovado | Verde |
| `3` | Reprovado | Vermelho |

---

## Endpoints consumidos

| Recurso | Endpoint |
|---|---|
| Unidades Acadêmicas | `GET /api/unidades-academicas/` |
| Departamentos | `GET /api/departamentos/` |
| Cursos | `GET /api/cursos/` |
| Alunos | `GET /api/alunos/` |
| Professores | `GET /api/professores/` |
| TCCs (lista) | `GET /api/tccs/` |
| TCC (detalhe) | `GET /api/tccs/:id/` |
| TCC (criar) | `POST /api/tccs/` (multipart/form-data) |
| TCC (editar) | `PATCH /api/tccs/:id/` (multipart/form-data) |
| Estatísticas | `GET /api/tccs/estatisticas/` |
