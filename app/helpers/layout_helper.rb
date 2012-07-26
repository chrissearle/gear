module LayoutHelper
  include ActsAsTaggableOn::TagsHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end

  def login_provider_names
    providers = LOGIN_PROVIDERS.map { |p| p.to_s.capitalize }

    providers.join ", "
  end

  def link_with_icon(icon, text, white=false)
    "<i class='#{white ? "#{icon} icon-white" : icon}'></i> #{text}".html_safe
  end

  def bootstrap_type(type)
    case type
      when :alert
        "warning"
      when :error
        "error"
      when :notice
        "info"
      when :success
        "success"
      else
        type.to_s
    end
  end
end
