class AvatarUploader < CarrierWave::Uploader::Base
  storage :fog
  storage :file

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.jpg"].compact.join('_'))
  end
end
