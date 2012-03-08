class Notice < ActiveRecord::Base
	belongs_to :admin_user
	belongs_to :category

	#before_save :set_admin_user_id

	def set_admin_user_id
		self.admin_user_id = AdminUser.current_admin_user
	end

	has_attached_file :image,
					  :styles => {:medium => "400x400>", :tumb => "200x200#"}, 
					  :path => ":rails_root/public/system/:attachment/:id/:style/:normalized_image_file_name",
					  :url => "/system/:attachment/:id/:style/:normalized_image_file_name" 

	Paperclip.interpolates :normalized_image_file_name do |attachment, style|
		attachment.instance.normalized_image_file_name
	end

	def normalized_image_file_name
		"#{self.id}-#{self.image_file_name.gsub( /[^a-zA-Z0-9_\.]/, '_')}" 
	end

	validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 5.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
