require 'rails_helper'

RSpec.describe "kinds/show", type: :view do
  before(:each) do
    @kind = assign(:kind, Kind.create!(
      :title => "Title",
      :category => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
  end
end
