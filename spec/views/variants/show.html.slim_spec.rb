require 'rails_helper'

RSpec.describe "variants/show", type: :view do
  before(:each) do
    @variant = assign(:variant, Variant.create!(
      :product => nil,
      :color => nil,
      :sizes => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
