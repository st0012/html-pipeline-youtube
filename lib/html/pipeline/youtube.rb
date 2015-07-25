require "html/pipeline"
require "html/pipeline/youtube/version"
require "html/pipeline/youtube/youtube_filter.rb"

module HTML
  class Pipeline
    autoload :YoutubeFilter, 'html/pipeline/youtube/youtube_filter'
  end
end
