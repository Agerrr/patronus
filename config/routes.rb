Rails.application.routes.draw do
  # for pdfs
  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  resources :cards
  resources :users
  resources :contracts
end
