# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require "stud/buffer"
require "rubygems"
require "uuidtools"
require "net/http"
require "uri"
require "json"

# You can learn more at https://lucene.apache.org/solr/[the Solr home page]

class LogStash::Outputs::SolrPost < LogStash::Outputs::Base
  include Stud::Buffer

  config_name "solr_post"


  # URL used to connect to Solr
  config :solr_url, :validate => :string

  # Number of events to queue up before writing to Solr
  config :flush_size, :validate => :number, :default => 100

  # Amount of time since the last flush before a flush is done even if
  # the number of buffered events is smaller than flush_size
  config :idle_flush_time, :validate => :number, :default => 1

  # Solr document ID for events. You'd typically have a variable here, like
  # '%{foo}' so you can assign your own IDs
  config :document_id, :validate => :string, :default => nil

  public
  def register
    buffer_initialize(
      :max_items => @flush_size,
      :max_interval => @idle_flush_time,
      :logger => @logger
    )
  end #def register

  public
  def receive(event)
    
    buffer_receive(event)
  end #def receive

  public
  def flush(events, close=false)
    # The documents array below is NOT being used currently, however the next version will utilize this.
    documents = []  #this is the array of hashes that we push to Solr as documents

    events.each do |event|
        document = event.to_hash()
        document["@timestamp"] = document["@timestamp"].iso8601 #make the timestamp ISO
        if @document_id.nil?
          document["id"] = UUIDTools::UUID.random_create    #add a unique ID
        else
          document["id"] = event.sprintf(@document_id)      #or use the one provided
        end
        url = URI.parse(@solr_url)
        req = Net::HTTP::Post.new(@solr_url, initheader = {'Content-Type' =>'application/json'})
        req.body = '{add:{ doc:' + JSON.generate(document) + ',boost:1.0,overwrite:true,commitWithin:1000}}'
        res = Net::HTTP.start(url.host,url.port) do |http|
          http.request(req)
        end
    end
    rescue Exception => e
      @logger.warn("An error occurred while indexing: #{e.message}")
  end #def flush
end #class LogStash::Outputs::SolrPost
