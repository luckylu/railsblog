class Post < ActiveRecord::Base
	include Klog
	belongs_to :user
	has_many :comments, dependent: :destroy
	before_save :fill_html_content

	def fill_html_content
		self.html_content = Klog::Markdown.render(self.content)
	end
end
