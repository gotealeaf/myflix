class LargeCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fill => [665, 375]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
