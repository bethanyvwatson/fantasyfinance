require "rails_helper"

RSpec.describe Transaction, type: :model, validations: true do
  it "validates presence of name, email, profile, and password" do
    attrs = %i(amount date description profile)
    details = %i(blank)

    transaction = described_class.new

    expect_validations_with_details(transaction, attrs, details)
  end
end
