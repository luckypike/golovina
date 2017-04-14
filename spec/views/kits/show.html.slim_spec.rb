require 'rails_helper'

RSpec.describe "kits/show", type: :view do
  before(:each) do
    @kit = assign(:kit, Kit.create!(
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
