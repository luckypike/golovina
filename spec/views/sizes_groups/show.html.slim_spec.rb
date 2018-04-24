require 'rails_helper'

RSpec.describe "sizes_groups/show", type: :view do
  before(:each) do
    @sizes_group = assign(:sizes_group, SizesGroup.create!(
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
