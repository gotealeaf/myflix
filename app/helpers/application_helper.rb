module ApplicationHelper
  def my_form_for(record, options = {}, &proc)
    form_for(record, options.merge!({builder: MyFormBuilder}), &proc)
  end

  def options_for_video_reviews(current_rating=nil)
    options_for_select(([5,4,3,2,1].map { |number| [pluralize(number, "Star")]}), 
                        selected: pluralize(current_rating, "Star"))
  end
end
