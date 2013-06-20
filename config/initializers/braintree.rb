require 'braintree'

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = ENV["SANDBOX_BRAINTREE_CONFIGURATION_MERCHANT_ID"]
Braintree::Configuration.public_key = ENV["SANDBOX_BRAINTREE_CONFIGURATION_PUBLIC_KEY"]
Braintree::Configuration.private_key = ENV["SANDBOX_BRAINTREE_CONFIGURATION_PRIVATE_KEY"]
