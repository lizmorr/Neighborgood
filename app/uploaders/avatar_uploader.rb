class AvatarUploader < CarrierWave::Uploader::Base
  storage :fog
  storage :file

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
