class Post < ActiveRecord::Base
	include Klog
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_and_belongs_to_many :categories 
	before_save :fill_html_content
	validates :title, :content, presence: true

	def fill_html_content
		self.html_content = Klog::Markdown.render(self.content)
	end
end
