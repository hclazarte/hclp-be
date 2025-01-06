Rails.application.config.two_factor_max_attempts = ENV.fetch("TWO_FACTOR_MAX_ATTEMPTS", 3).to_i
