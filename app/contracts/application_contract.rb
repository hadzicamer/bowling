class ApplicationContract < Dry::Validation::Contract
  config.messages.backend = :i18n
  config.messages.default_locale = :en
end
