require 'rails_helper'

RSpec.describe "themes/new", type: :view do
  before(:each) do
    assign(:theme, Theme.new(
      :title => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders new theme form" do
    render

    assert_select "form[action=?][method=?]", themes_path, "post" do

      assert_select "input#theme_title[name=?]", "theme[title]"

      assert_select "input#theme_slug[name=?]", "theme[slug]"
    end
  end
end
