require 'spec_helper'

describe ApplicationHelper do

  context "on wrap text" do

    it "should wrap a big text" do
      text = "Um longo texto que nao pode ser exibido dessa forma no box de ultimas boas praticas."
      helper.wrap_text(text, 60).should == "Um longo texto que nao pode ser exibido dessa forma no box de..."
    end

    it "should dont wrap a little text" do
      text = "Um pequeno texto."
      helper.wrap_text(text, 60).should == "Um pequeno texto."
    end

  end

  context "on render wall message" do
    it "should only allow 'a' tags" do
      helper.render_wall_message("<strong>texto negrito</strong>").should == '<p>&lt;strong&gt;texto negrito&lt;/strong&gt;</p>'
    end

    it "should create html element for links" do
      helper.render_wall_message("Veja o link a seguir: http://example.com").should == '<p>Veja o link a seguir: <a href="http://example.com" class="normal-link" target="_blank">http://example.com</a></p>'
    end

    it "should render a inequation" do
      helper.render_wall_message("1 + 2 < 4").should == '<p>1 + 2 &lt; 4</p>'
    end
  end

end


