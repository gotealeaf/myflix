module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
    class_attribute :slug_column
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.send(self.class.slug_column.to_sym))
    obj = self.class.find_by_slug the_slug
    x = 1
    while obj && obj != self
      the_slug[-1] = x.to_s if x > 0
      obj = self.class.find_by_slug the_slug
      x += 1
    end

    self.slug = the_slug && the_slug.downcase 
  end

  def to_slug(name)
    return nil if name.nil?
    name.strip.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')
    name.gsub!(/-+/, '-')
    name = name + '-' + '0'
  end
end
