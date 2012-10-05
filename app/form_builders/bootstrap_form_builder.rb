class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :tag, to: :@template

  %w[text_field text_area].each do |method_name|
    define_method(method_name) do |name, *args|
      content_tag :div, class: "control-group" do
        field_label(name, args) + (content_tag :div, class: "controls" do
          options = args.extract_options!
          options[:class] = method_name
          super(name, options)
        end)
      end
    end
  end

  def select(name, *args)
    @template.content_tag :div, class: "control-group" do
      field_label(name, args) + (content_tag :div, class: "controls" do
        super
      end)
    end
  end

  def submit(*args)
    options = args.extract_options!
    options[:class] = "btn btn-primary"
    content_tag :div, class: "form-actions" do
      super(options)
    end
  end

  private

  def field_label(name, *args)
    label(name, :class => "control-label")
  end
end
