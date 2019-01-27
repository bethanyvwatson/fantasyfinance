module ValidationsHelper

  def expect_validations_with_details(src, expected_attrs, expected_details)
    expect(src.valid?).to be_falsey
    expect_attr_errors(src, expected_attrs)

    details = get_error_details(src)

    expect(details.uniq.sort).to eq(expected_details.sort)
  end

  def expect_attr_errors(src, expected_attrs)
    expect(src.errors.keys.sort).to eq(expected_attrs.sort)
  end

  def get_error_details(src)
    src.errors.details.map { |k, v| v.first[:error] }.flatten
  end
end