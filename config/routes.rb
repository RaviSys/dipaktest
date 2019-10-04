Rails.application.routes.draw do
	root 'users#index'
	resources :users do 
		collection do
			post :file_import
			get :show_data
		end
	end
end
