Rails.application.routes.draw do
  root to: 'shortcuts#new'

  get '/:shortcut_key' => 'shortcuts#show', as: :shortcut, shortcut_key: /[[:alnum:]]{7}/

  resources :shortcuts, only: %i(create)
end
