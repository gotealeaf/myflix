FactoryGirl.define do
  factory :video do
    title "Monk"
    description "testing1"
    large_cover_image_url "url_str"
    small_cover_image_url "url_str"
    category_id 1
  end

  factory :invalid_video, class: Video do
    title "Monk"
    description "testing1"
    large_cover_image_url "url_str"
    small_cover_image_url "url_str"
  end
end
