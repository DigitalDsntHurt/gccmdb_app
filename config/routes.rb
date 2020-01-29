Rails.application.routes.draw do
  


  get 'about/home'
  get 'about/docs'
  get 'measures/index_master' => 'measures#index_master'
  get 'measures/index_pages' => 'measures#index_pages'
  get 'measures/index_simple_pages' => 'measures#index_simple_pages'
  resources :measures
  



  resources :measure_targets
  



  resources :data_sources
  


  get 'countries/index_master' => 'countries#index_master'
  resources :countries

  


  get 'scratch/back'
  get 'scratch/homepage'
  get 'scratch/one'
  get 'scratch/summaries'




  root 'about#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
