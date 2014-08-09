module ApplicationHelper

  def review_options(selected=nil)
    options_for_select([5,4,3,2,1].map { |x| [pluralize(x, "Star"), x] }, selected)
  end

  def genre_options
    options_for_select(Genre.all.map { |x| [x.name.titleize, x.id] })
  end
end
