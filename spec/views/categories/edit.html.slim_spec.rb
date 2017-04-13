require 'rails_helper'

RSpec.describe "categories/edit", type: :view do
  before(:each) do
    @category = assign(:category, Category.create!(
      :title => "MyString",
      :slug => "MyString",
      :desc => "MyText"
    ))
  end

  it "renders the edit category form" do
    render

    assert_select "form[action=?][method=?]", category_path(@category), "post" do

      assert_select "input#category_title[name=?]", "category[title]"

      assert_select "input#category_slug[name=?]", "category[slug]"

      assert_select "textarea#category_desc[name=?]", "category[desc]"
    end
  end
end
