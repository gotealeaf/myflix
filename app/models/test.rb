def recent_videos
  @videos_sorted = Category.find(id).videos.sort_by { |video| video.created_at}.reverse
  if @videos_sorted.size < 6
    puts @videos_sorted
  else
    puts @videos_sorted.last(6)
  end
end

id = 1

