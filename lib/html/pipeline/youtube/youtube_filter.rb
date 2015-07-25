module HTML
  class Pipeline
    class YoutubeFilter < TextFilter
      def call
        # This filter converts youtube video's url into youtube iframe.
        #
        # Context options:
        #   :video_width - integer, sets iframe's width
        #   :video_height - integer, sets iframe's height
        #   :video_frame_border - integer, sets iframe border's width
        #   :video_wmode - string, sets iframe's wmode option
        #   :video_autoplay - boolean, whether video should autoplay
        #   :video_hide_related - boolean, whether shows related videos
        regex = /(https?:\/\/)?(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\?\S+)?/
        @text.gsub(regex) do
          youtube_id = $4
          width = context[:video_width] || 420
          height = context[:video_height] || 315
          frameborder = context[:video_frameborder] || 0
          wmode = context[:video_wmode]
          autoplay = context[:video_autoplay] || false
          hide_related = context[:video_hide_related] || false
          src = "//www.youtube.com/embed/#{youtube_id}"
          params = []
          params << "wmode=#{wmode}" if wmode
          params << "autoplay=1" if autoplay
          params << "rel=0" if hide_related
          src += "?#{params.join '&'}" unless params.empty?

          %{<div class="video youtube"><iframe width="#{width}" height="#{height}" src="#{src}" frameborder="#{frameborder}" allowfullscreen></iframe></div>}
        end
      end
    end
  end
end
