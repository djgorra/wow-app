require 'rails_helper'

RSpec.describe "characters/show", type: :view do
  before(:each) do
    @character = assign(:character, Character.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
