if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider         => 'AWS',
      :aws_access_key_id => ENV['AKIAJSMBXJ7PV57IMNKQ'],
      :aws_secret_access_key => ENV['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']
      }
    config.fog_directory = ENV['ganesanrailsbucket']
  end
end