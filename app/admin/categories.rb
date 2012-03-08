ActiveAdmin.register Category do
	menu :if => proc{ can?(:manage, Category) }  
end
