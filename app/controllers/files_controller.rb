class FilesController < ApplicationController
  require 'aws-sdk'

  def presigned_url
    s3_service = S3Service.new()
    presigned_url = s3_service.get_presigned_url(params[:dir], params[:file_name])
    render json: { presigned_url: presigned_url }, status: 200
  rescue StandardError => e
    render json: { error: e.message }, status: 500
  end
end