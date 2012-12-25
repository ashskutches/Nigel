OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '119635888197519', 'e287452ec64c2b7cc137ca93983374ba'
end
