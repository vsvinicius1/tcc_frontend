Rails.application.routes.draw do
  root "dashboard#index"

  get  "dashboard", to: "dashboard#index", as: :dashboard

  resources :tccs, only: [:index, :new, :create, :edit, :update]
  resources :alunos,              only: [:index]
  resources :professores,         only: [:index]
  resources :cursos,              only: [:index]
  resources :departamentos,       only: [:index]
  resources :unidades_academicas, only: [:index]
end
