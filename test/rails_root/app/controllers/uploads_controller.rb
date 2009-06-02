class UploadsController < Uploader::UploadsController

  def get_redirect(source)
    case source
    when :destroy_success
      '/destroy_success'
    when :create_success
      '/create_success'
    when :create_failure
      '/create_failure'
    when :permission_denied
      '/permission_denied'
    else
      raise 'An unknown source was provided to get_redirect'
    end
  end
  
end