require 'rails_helper'

RSpec.describe "themes/edit", type: :view do
  before(:each) do
    @theme = assign(:theme, Theme.create!(
      :title => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit theme form" do
    render

    assert_select "form[action=?][method=?]", theme_path(@theme), "post" do

      assert_select "input#theme_title[name=?]", "theme[title]"

      assert_select "input#theme_slug[name=?]", "theme[slug]"
    end
  end
end
