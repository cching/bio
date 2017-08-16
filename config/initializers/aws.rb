Aws.config.update({
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY'], ENV['SECRET_KEY'], {region: ENV['AWS_REGION']})
})
#set access_key_id and secret_key, set region