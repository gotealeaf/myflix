class SmallCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fill => [166, 236]
end