require "rails_helper"

RSpec.describe Profile, type: :model, validations: true do

  it "validates presence of name, email, and password" do
    attrs = %i(first_name last_name email password)
    details = %i(blank)
    profile = described_class.new

    expect_validations_with_details(profile, attrs, details)
  end

  it "validates uniqueness of email" do
    attrs = %i(email)
    details = %i(taken)

    existing_profile = create(:profile)
    dup = build(:profile, email: existing_profile.email)
    expect_validations_with_details(dup, attrs, details)
  end

  describe "full_name" do
    it "returns the first and last name separated by a space" do
      profile = create(:profile)
      expect(profile.full_name).to eq("#{profile.first_name} #{profile.last_name}")
    end
  end
end
