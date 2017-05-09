require 'spec_helper'

describe HTML::Pipeline::YoutubeFilter do
  subject { HTML::Pipeline::YoutubeFilter }
  let(:youtube_url) { "https://www.youtube.com/watch?v=Kg4aWWIsszw" }

  it 'has a version number' do
    expect(HTML::Pipeline::Youtube::VERSION).not_to be nil
  end

  context "With other filter's result" do
    it "doesn't affect links in markdown" do
      markdown_link = "[Video](https://www.youtube.com/watch?v=Kg4aWWIsszw)"

      expect(subject.to_html(markdown_link)).to eq(markdown_link)
    end
    it "doesn't affect links in html tag" do
      hyper_link = %(<a href="https://www.youtube.com/watch?v=Kg4aWWIsszw">Video</a>)

      expect(subject.to_html(hyper_link)).to eq(hyper_link)
    end
    it "does affect links in a div" do
      hyper_link = %(<div>https://www.youtube.com/watch?v=Kg4aWWIsszw</div>)

      expect(subject.to_html(hyper_link)).to eq(
        %(<div>\n\n<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/Kg4aWWIsszw" frameborder="0" allowfullscreen></iframe></div></div>)
      )
    end
    it "does affect links after a br" do
      hyper_link = %(<br>https://www.youtube.com/watch?v=Kg4aWWIsszw)

      expect(subject.to_html(hyper_link)).to eq(
        %(<br>\n\n<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/Kg4aWWIsszw" frameborder="0" allowfullscreen></iframe></div>)
      )
    end
    it "does not consume whitespace" do
      source = 'Check out https://www.youtube.com/watch?v=Kg4aWWIsszw now'
      expect(subject.to_html(source)).to eq(
        %(Check out \n\n<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/Kg4aWWIsszw" frameborder="0" allowfullscreen></iframe></div> now)
      )
    end
    it "supports /embed URLs" do
      source = 'https://www.youtube.com/embed/Kg4aWWIsszw'
      expect(subject.to_html(source)).to eq(
        %(\n\n<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/Kg4aWWIsszw" frameborder="0" allowfullscreen></iframe></div>)
      )
    end
  end

  context "With no options" do
    it "generates iframe with default setting" do
      expect(subject.to_html(youtube_url)).to eq(
        %(\n\n<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/Kg4aWWIsszw" frameborder="0" allowfullscreen></iframe></div>)
      )
    end
  end

  context "With options" do
    it "generated iframe with custom option" do
      result = subject.to_html(
        youtube_url,
        video_width: 500,
        video_height: 100,
        video_frameborder: 5,
        video_autoplay: true,
        video_hide_related: true
      )

      expect(result).to eq(
        %(\n\n<div class="video youtube"><iframe width="500" height="100" src="//www.youtube.com/embed/Kg4aWWIsszw?autoplay=1&rel=0" frameborder="5" allowfullscreen></iframe></div>)
      )
    end
  end
end
