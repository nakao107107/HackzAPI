class S3Service
  attr_reader :bucket

  def initialize
    @bucket = Aws::S3::Resource.new(region: ENV['AWS_REGION']).bucket("hackz")
  end

  def get_presigned_url(dir, file_name)
    presigned_url = bucket.object(dir << secured_name(file_name)).presigned_url(
        :put, expires_in: 60 * 5, acl: 'public-read'
    )
    presigned_url
  end

  private
  def secured_name(file_name)
    "#{Date.today}-#{SecureRandom.hex(8)}#{file_name}"
  end
end