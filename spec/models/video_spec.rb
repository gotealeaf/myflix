require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Road Runner", description: "Chased constantly!", small_cover_url: "/tmp/road_runner.jpg", large_cover_url: "/tmp/road_runner_large.jpg", category_id: 1)
    video.save
    Video.first.title.should           == "Road Runner"
    Video.first.description.should     == "Chased constantly!"
    Video.first.small_cover_url.should == "/tmp/road_runner.jpg"
    Video.first.large_cover_url.should == "/tmp/road_runner_large.jpg"
    Video.first.category_id.should     == 1
  end
end

# Deprecation Warnings:
# Using `should` from rspec-expectations' old `:should` syntax without explicitly enabling the syntax is deprecated. Use the new `:expect` syntax or explicitly enable `:should` instead. Called from /Users/matthewmalone/Sites/myflix/spec/models/video_spec.rb:7:in `block (2 levels) in <top (required)>'.
# If you need more of the backtrace for any of these deprecations to identify where to make the necessary changes, you can configure `config.raise_errors_for_deprecations!`, and it will turn the deprecation warnings into errors, giving you the full backtrace.
# 1 deprecation warning total
# Randomized with seed 35627