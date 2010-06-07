require 'rss'
require 'mechanize'

module Lowes

  class Job

    FEED_URL = "http://feeds2.feedburner.com/Lowes-Careers-All"

    # public api

    def self.all
      feed.items.map do |item|
        create_job_from_item(item)
      end
    end

    # internal methods

    def self.data
      open(FEED_URL).read
    end

    def self.feed
      RSS::Parser.parse(data, false)
    end

    def self.create_job_from_item(item)
      item.link =~ /jobid=(.*)$/
      id = $1
      Job.new(
              :id           => id,
              :title        => item.title,
              :redirect_url => item.link,
              :category     => item.category.content
              )
    end

    attr_reader :id, :title, :redirect_url, :category

    def initialize(attributes = {})
      attributes.each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end
    end

    # public api

    def url
      Mechanize::Page::Meta.parse(redirect_page.at("meta").attr("content"), nil).last
    end

    def location
      page.search("#pc-rtg-main tr:nth-child(1) .jobDetailValue span").text.strip.gsub(/\s+/, ' ')
    end

    def city
      split_location[0]
    end

    def state
      split_location[-1]
    end

    def description
      job_details[6].text
    end

    # internal methods

    def agent
      @agent ||= Mechanize.new
    end

    def page
      @page ||= agent.get(url)
    end

    def redirect_page
      @redirect_page ||= agent.get(redirect_url)
    end

    def job_details
      @details ||= page.search(".TEXT")
    end

    def split_location
      location.split(", ")
    end

  end

end
