FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name { "Test Application" }
    scopes { "public" }
    uid { SecureRandom.hex(16) }
    secret { SecureRandom.hex(32) }
    redirect_uri { "https://example.com/callback" }
  end
end
