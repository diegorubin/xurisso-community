require 'rails_helper'

describe ApplicationHelper, type: :helper do

  context "on wrap text" do

    it "should wrap a big text" do
      text = "Um longo texto que nao pode ser exibido dessa forma no box de ultimas boas praticas."
      expect(helper.wrap_text(text, 60)).to eql("Um longo texto que nao pode ser exibido dessa forma no box de...")
    end

    it "should dont wrap a little text" do
      text = "Um pequeno texto."
      expect(helper.wrap_text(text, 60)).to eql("Um pequeno texto.")
    end

  end

  context "on render wall message" do
    it "should only allow 'a' tags" do
      expect(helper.render_wall_message("<strong>texto negrito</strong>"))
        .to(eql('<p>&lt;strong&gt;texto negrito&lt;/strong&gt;</p>'))
    end

    it "should create html element for links" do
      expect(helper.render_wall_message("Veja o link a seguir: http://example.com"))
        .to(eql('<p>Veja o link a seguir: <a target="_blank" class="normal-link" href="http://example.com">http://example.com</a></p>'))
    end

    it "should render a inequation" do
      expect(helper.render_wall_message("1 + 2 < 4"))
        .to(eql('<p>1 + 2 &lt; 4</p>'))
    end
  end

end


