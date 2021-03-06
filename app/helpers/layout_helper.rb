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

  def dropbox_link_text
    if current_user.dropbox_session.nil? || current_user.dropbox_session.empty?
      return t('dropbox.link')
    else
      return t('dropbox.relink')
    end
  end

  def get_document_link(path)
    current_user.get_client.media(path)['url']
  end

  def dropbox_quota_used(info)
    number_to_human_size (info['quota_info']['normal'].to_f + info['quota_info']['shared'].to_f)
  end

  def dropbox_quota(info)
    number_to_human_size info['quota_info']['quota'].to_f
  end
end
