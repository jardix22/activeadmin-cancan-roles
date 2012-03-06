ActiveAdmin.register AdminUser do
	menu :if => proc{ can?(:manage, AdminUser) }

	controller.authorize_resource 

	index do
		column :email
		column :role
		column :current_sign_in_at
		column :last_sign_in_at
		column :sign_in_count
		default_actions
	end

	form do |f|
		f.inputs "Admin Details" do
			f.input :email
			f.input :role, :collection => AdminUser::ROLES
			f.input :password, :type => :password
			f.input :password_confirmation, :type => :password
		end
		f.buttons
	end
end
