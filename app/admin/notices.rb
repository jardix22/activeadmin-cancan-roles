ActiveAdmin.register Notice do
	#menu :if => proc{ can?(:manage, Notice) }
	#controller.authorize_resource 

	index do
		column "ID", :id
		column "Title", :sortable => :title do |notice|
			link_to notice.title, admin_notice_path(notice)
		end
		column "Category", :sortable => :category_id do |notice|
			notice.category.name
		end
		column :admin_user
		column "Create Date", :created_at
		column "Curren User" do 
			current_admin_user.id
		end
		default_actions
	end

	form do |f|
		f.inputs "User" do 
			f.input :admin_user_id,:as => :select,  :collection => Hash[AdminUser.all.map{|b| [b.email,b.id]}]
		end
		f.inputs "Category" do
			f.input :category, :collection => Category.all
		end
		f.inputs "Notice" do 
			f.input :title
			f.input :description
			f.input :image
		end
		f.buttons do
			f.action :submit, :as => :button
			f.action :cancel, :as => :link 
		end
		f.buttons
	end

	# CUSTUMIZING CONTROLLERS
	member_action :lock, :method => :post do
		notice = Notice.create(params[:product])

		redirect_to :location => admin_notices_path
	end
end
