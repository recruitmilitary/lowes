require 'rss'
require 'mechanize'

module Lowes

  class Job

    FEED_URL = "http://feeds2.feedburner.com/Lowes-Careers-All"

    ExpiredError = Class.new(StandardError)
    UnknownFormat = Class.new(StandardError)

    def self.parse(item)
      url = parse_url_from_meta(item.link)
      case url
      when /brassring/
        parse_kenexa(item, url)
      when /peopleclick/
        parse_peopleclick(item, url)
      else
        raise UnknownFormat
      end
    end

    def self.parse_kenexa(item, url)
      page = agent.get(url)
      raise ExpiredError if page.search("td td").text =~ /expired/
      {
        :id    => page.search(".TEXT")[1].text,
        :url   => url,
        :title => item.title.gsub(/ -\w\w-.*$/, ''),
        :category => item.category.content,
        :location => page.search(".TEXT")[5].text,
        :description => page.search(".TEXT")[6].children.map { |c| c.text }.join("\n")
      }
    end

    def self.parse_peopleclick(item, url)
      page = agent.get(url)
      raise ExpiredError if page.search("li").text =~ /no longer active/
      {
        :id => page.search(".jobDetailValue")[0].text,
        :url => url,
        :title => item.title.gsub(/ -\w\w-.*$/, ''),
        :category => item.category.content,
        :location => page.search(".jobDetailValue")[1].text.strip.gsub(/\s+/, ' '),
        :description => page.search(".pc-rtg-body").text.strip
      }
    end

    def self.parse_url_from_meta(redirect_url)
      redirect_page = agent.get(redirect_url)
      Mechanize::Page::Meta.parse(redirect_page.at("meta").attr("content"), nil).last
    end

    def self.agent
      @agent ||= Mechanize.new
    end

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
      page.search(".pc-rtg-body").text.strip
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

    def split_location
      location.split(", ")
    end

  end

end
