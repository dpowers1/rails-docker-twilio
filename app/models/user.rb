class User < ApplicationRecord
  has_many :texts
  validate :real_phone_number
  after_validation :flatten_phone_number

  def real_phone_number
    phone_number_regex = /^\(?[\d]{3}\)?[\s|-]?[\d]{3}-?[\d]{4}$/
    unless phone_number =~ phone_number_regex
      errors.add(:phone_number, "Must be 10 digits. Example (555) 123-4567, 555-123-4567, or 5551234567")
    end
  end

  def flatten_phone_number
    phone_number.gsub!(/[^0-9]/, '')
  end
end
