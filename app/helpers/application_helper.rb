module ApplicationHelper
  def my_form_for(record, options = {}, &block)
    form_for(record, options.merge!({builder: MyFormBuilder}), &block)
  end
end
