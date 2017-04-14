require 'rails_helper'

RSpec.describe "kits/index", type: :view do
  before(:each) do
    assign(:kits, [
      Kit.create!(
        :title => "Title"
      ),
      Kit.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of kits" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
