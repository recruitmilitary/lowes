require 'rss'
require 'mechanize'

module Lowes

  class Job

    FEED_URL = "http://feeds2.feedburner.com/Lowes-Careers-All"

    ExpiredError = Class.new(StandardError)

    UnknownFormat = Class.new(StandardError)

    module Agent

      def agent
        @agent ||= Mechanize.new
      end

    end

    class Parser

      include Agent
      extend Agent

      def self.parse(item, url)
        new(item, url).parse
      end

      def self.parse_url_from_meta(redirect_url)
        redirect_page = agent.get(redirect_url)
        Mechanize::Page::Meta.parse(redirect_page.at("meta").attr("content"), nil).last
      end

      attr_reader :item, :url

      def initialize(item, url)
        @item, @url = item, url
      end

      def title
        item.title.gsub(/ -\w\w-.*$/, '')
      end

      def category
        item.category.content
      end

      private

      def page
        @page ||= agent.get(url)
      end

    end

    class KenexaParser < Parser

      def description
        node = page.search(".TEXT")[6]
        if node
          node.children.map { |c| c.text }.join("\n")
        else
          ""
        end
      end

      def parse
        raise ExpiredError if page.search("td td").text =~ /expired/
        {
          :id    => field_value_for("Job ID"),
          :url   => url,
          :title => title,
          :category => category,
          :location => field_value_for("Location Name"),
          :description => description
        }
      end

      def field_labels
        @field_labels ||= page.search(".Fieldlabel").map { |l| l.text }
      end

      def field_values
        @field_values ||= page.search(".TEXT").map { |f| f.text }
      end

      def field_value_for(label)
        index = field_labels.index(label)
        if index
          field_values[index]
        else
          nil
        end
      end

    end

    def self.parse(item)
      url = Parser.parse_url_from_meta(item.link)
      case url
      when /brassring/
        KenexaParser.parse(item, url)
      else
        raise UnknownFormat
      end
    end

    def self.all
      feed.items.map do |item|
        retry_count = 0
        begin
          Job.new parse(item)
        rescue Job::ExpiredError
          $stderr.puts "Job::ExpiredError: ignoring #{item.link}"
          nil
        rescue Timeout::Error
          retry_count += 1
          $stderr.puts "Timeout::Error: attempt ##{retry_count} for #{item.link}"
          retry unless retry_count > 2
          nil
        end
      end.compact
    end

    def self.data
      open(FEED_URL).read
    end

    def self.feed
      RSS::Parser.parse(data, false)
    end

    attr_reader :id, :title, :url, :category, :location, :description

    def initialize(attributes = {})
      attributes.each do |k, v|
        instance_variable_set(:"@#{k}", v)
      end
    end

    def city
      split_location[0]
    end

    def state
      split_location[-1]
    end

    private

    def split_location
      if location
        location.split(", ")
      else
        [nil, nil]
      end
    end

  end

end
