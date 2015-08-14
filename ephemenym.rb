require 'simple_oauth'
require 'yaml'
require 'net/http'
require 'net/https'
require 'uri'

API_KEYS = YAML.load(File.read("keys.yml"))

# client = Twitter::REST::Client.new do |config|
#   config.consumer_key        = API_KEYS['CONSUMER_KEY']
#   config.consumer_secret     = API_KEYS['CONSUMER_SECRET']
#   config.access_token        = API_KEYS['ACCESS_TOKEN']
#   config.access_token_secret = API_KEYS['ACCESS_TOKEN_SECRET']
# end

# https://api.twitter.com/1.1/account/update_profile.json?name=Duke%20Greene

class EphemenymClient
  attr_reader :credentials

  def initialize(credentials)
    raise ArgumentError, "must provide consumer_key, consumer_secret, token, and token_secret" unless valid_credentials?(credentials)
    @credentials = credentials
  end

  def querify(string)
    string.gsub(" ", "%20")
  end

  def update_name(ephemenym)
    raise ArgumentError, "New name must be fewer than 20 characters long" if ephemenym.length > 20

    querified_name = querify(ephemenym)
    url = "https://api.twitter.com/1.1/account/update_profile.json?name=#{ephemenym}"
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
   
    request = Net::HTTP::Post.new(uri)
    request.set_form_data({"name" => ephemenym})
    request["Authorization"] = oauth_header(request)
    response = http.request(request)

    return response
  end

  private

  # A helper method to generate the OAuth Authorization header given
  # an Net::HTTP::GenericRequest object and a Hash of params
  def oauth_header(request)
    SimpleOAuth::Header.new(request.method, request.uri, URI.decode_www_form(request.body), credentials).to_s
  end

  def valid_credentials?(credentials)
    [:consumer_key, :consumer_secret, :token, :token_secret].all? { |key| credentials[key] }
  end
end

class EphemenymGenerator
  attr_reader :full_message

  def initialize(full_message)
    @full_message = full_message
  end

  def get_ephemenyms
    # Not sure what Twitter will consider fair game. Gonna rule out stuff I think will break and then test to see if it actually does break it.
    deboned_message = full_message.gsub(/[\'\"\%\&]/, "")
    words = deboned_message.split(" ")
    raise ArgumentError, "Oops, one of the words in this message is too long, please keep character count at or under 20 per word." unless words.all? { |word| word.length < 21}
    raise ArgumentError, "Sorry, too meta. Twitter HATES when you talk about it in your username, so don't say 'twitter' in your message please." if words.any? { |word| word.downcase == "twitter"}
    ephemenyms = ["-BEGIN EPHEMENYM-"]
    pending_string = ""
    words.each do |word| 
      if pending_string.empty?
        pending_string << word
      elsif pending_string.length + word.length + 1 > 20
        ephemenyms << pending_string
        pending_string = word
      else
        pending_string = pending_string + ' ' + word
      end
    end
    ephemenyms << pending_string
    ephemenyms << "-END EPHEMENYM-"
    ephemenyms << "-EPHEMENYM RESET-"
    ephemenyms
  end

end

# For now, Let's cycle between names on a loop. To do: Use the name attribute to send messages.

client = EphemenymClient.new(
  consumer_key: API_KEYS['CONSUMER_KEY'],
  consumer_secret: API_KEYS['CONSUMER_SECRET'],
  token: API_KEYS['ACCESS_TOKEN'],
  token_secret: API_KEYS['ACCESS_TOKEN_SECRET']
)

generator = EphemenymGenerator.new("A few questions: Is 140 too many? Could 20 be enough? Who decides when a missive is obsolete? What if your identity is less about what you said in the past and more about who you are in the present? Are user name histories kept in the data archives of social giants? Could we use our names to say more than our names? And if we could change our names as quickly as we change our minds, could our names change other minds too?")

puts "*******************"
puts "Pending ephemenyms:"
puts "*******************\n"

ephemenyms = generator.get_ephemenyms
puts ephemenyms
puts

puts "*******************"
puts "Beginning Twitter \"Real Name\" updates..."
puts "*******************\n"

10.times do
  ephemenyms.each do |ephemenym|
    sleep 5
    client.update_name(ephemenym)
    puts "Twitter name updated to: '#{ephemenym}'."
    puts "..."
    sleep 55
  end
end

client.update_name("#BumbleGrad #DBC")

