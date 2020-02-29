Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: proc { [200, {}, ['Rails API runs in server']] }
  mount ActionCable.server => '/cable'
end
