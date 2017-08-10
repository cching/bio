Aws.config.update({
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY'], ENV['SECRET_KEY'])
})
#set access_key_id and secret_key

Aws.config.update({region: ENV['AWS_REGION']})
#update region