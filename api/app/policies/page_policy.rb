# frozen_string_literal: true

PagePolicy = Struct.new :user, :page do
  def index?
    true
  end

  def about?
    true
  end

  def robots?
    index?
  end

  def contacts?
    index?
  end

  def instagram?
    index?
  end
end
