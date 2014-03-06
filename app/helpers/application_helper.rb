module ApplicationHelper
  def my_form_for(record, options = {}, &proc)
    form_for(record, options.merge!({builder: MyFormBuilder}), &proc)
  end
end
