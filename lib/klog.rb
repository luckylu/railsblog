module Klog
  class Markdown
    def self.render(text)
      return self.instance.render(text)
    end

    def self.instance
      @markdown ||= Redcarpet::Markdown.new(Klog::Render.new,  :autolink => true, :fenced_code_blocks => true, :no_intra_emphasis => true)
    end
  end

  class Render < Redcarpet::Render::HTML
    def initialize(extensions={})
      super(extensions.merge(:xhtml => true, :no_styles => true, :filter_html => true, :hard_wrap => true))
    end
  end
end