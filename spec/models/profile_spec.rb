require "rails_helper"

RSpec.describe Profile, type: :model do

  it "validates presence of name, email, and password" do
    expected_attrs = %i(first_name last_name email password)
    expected_details = %i(blank)

    profile = described_class.new

    expect(profile.valid?).to be_falsey
    expect_attr_errors(profile, expected_attrs)

    details = get_error_details(profile)

    expect(details.uniq.sort).to eq(expected_details.sort)
  end

  it "validates uniqueness of email" do
    expected_attrs = %i(email)
    expected_details = %i(taken)

    existing_profile = create(:profile)
    dup = build(:profile, email: existing_profile.email)

    expect(dup.valid?).to be_falsey
    expect_attr_errors(dup, expected_attrs)

    details = get_error_details(dup)
    expect(details.uniq.sort).to eq(expected_details.sort)
  end

  describe "full_name" do
    it "returns the first and last name separated by a space" do
      profile = create(:profile)
      expect(profile.full_name).to eq("#{profile.first_name} #{profile.last_name}")
    end
  end

  def expect_attr_errors(src, expected_attrs)
    expect(src.errors.keys.sort).to eq(expected_attrs.sort)
  end

  def get_error_details(src)
    src.errors.details.map { |k, v| v.first[:error] }.flatten
  end
end
