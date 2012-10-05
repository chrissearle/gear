module ApplicationHelper
  def bootstrap_form_for(object, options = {}, &block)
    options[:builder] = BootstrapFormBuilder
    options[:html] = { :class => 'form-horizontal' }
    form_for(object, options, &block)
  end
end
