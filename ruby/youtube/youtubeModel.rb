#NOTE. Found a great example of YouTube's client on YouTube's API documentation website.
# Below is what they recommended with a few of my modifications.

# I AM RUNNING THE API WITH ruby 2.1.2, sinatra, and gem 'google-api-client', '0.7.1'

class YouTube

  require 'google/api_client'

  DEVELOPER_KEY = 'AIzaSyDfc_FwmFEMyKt2dkcG7HTEs1F9JvkPhdk'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  def get_service
    client = Google::APIClient.new(
      :key => DEVELOPER_KEY,
      :authorization => nil,
      :application_name => $PROGRAM_NAME,
      :application_version => '1.0.0'
    )
    youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    return client, youtube
  end

  def main(term)  #ADDED A PARAMETER TO USE WITH API

    @term = term.to_s

    client, youtube = get_service

    begin
      # Call the search.list method to retrieve results matching the specified
      # query term.
      search_response = client.execute!(
        :api_method => youtube.search.list,
        :parameters => {
          :part => 'snippet',
          :q => @term,
          :maxResults => 3
        }
      )

      videosResults = []

      # Add each result to the appropriate list, and then display the lists of
      # matching videos
      search_response.data.items.each do |search_result|
        case search_result.id.kind
          when 'youtube#video'
          video = {
              :title => "#{search_result.snippet.title}",
              :videoLink => "https://youtu.be/#{search_result.id.videoId}", #ADD HTTPS://YOUTU.BE/ TO MAKE VIDEOID INTO A LINK
              :imageUrl => "#{search_result.snippet.thumbnails.medium.url}"
            }
            videosResults << video #PUT VIDEO INTO VIDEORESULTS
        end
      end

      return videosResults #RETURN ONLY VIDEO RESULTS

    end
  end

end
