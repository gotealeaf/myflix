class MyFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    errors = object.errors[method.to_sym]
    if errors
      text += " <p class='text-danger'>#{errors.first.to_s.capitalize}</p>"
    end
    super(method, text.html_safe, options, &block)
  end
end
