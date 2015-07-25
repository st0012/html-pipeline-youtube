require 'spec_helper'

describe HTML::Pipeline::Youtube do
  subject { HTML::Pipeline::Youtube }
  let(:youtube_url) { "https://www.youtube.com/watch?v=Kg4aWWIsszw" }

  it 'has a version number' do
    expect(Html::Pipeline::Youtube::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(subject.to_html(youtube_url)).to eq(%(<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/Kg4aWWIsszw" frameborder="0" allowfullscreen></iframe></div>))
  end
end
