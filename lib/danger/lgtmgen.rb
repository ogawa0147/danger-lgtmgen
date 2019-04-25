require "danger/lgtmgen/version"
require "danger"

module Danger

  module URLType
    LGTMOON = 1
  end

  # class DangerLgtmgen
  class DangerLgtmgen < Plugin

    def initialize(url_type)
      @url_type = url_type
    end

    def github_markdown()
      case @url_type[:url_type]
      when URLType::LGTMOON then
        Lgtmmoon.new.github_markdown
      end
    end

    def html_tag()
      case @url_type[:url_type]
      when URLType::LGTMOON then
        Lgtmmoon.new.html_tag
      end
    end
  end

  class Lgtmmoon
    require "faraday"

    BASE_URL = "https://lgtmoon.herokuapp.com/".freeze
    RETRY_LIMIT_TIME = 3

    def github_markdown
      try = 0
      begin
        try += 1
        image_id = rand(20000)
        conn = Faraday::Connection.new(:url => BASE_URL) do |builder|
          builder.use Faraday::Request::UrlEncoded
          builder.use Faraday::Response::Logger
          builder.use Faraday::Adapter::NetHttp
        end
        response = conn.get "images/#{image_id}" do |req|
          req.options.timeout = 10
        end
        if response.success?
          puts "![LGTM]('#{BASE_URL}images/#{image_id}')"
        else
          if try >= RETRY_LIMIT_TIME
            puts "<p align='center'>LGTM</p>"
          end
          raise
        end
      rescue
        sleep(5)
        retry if try < RETRY_LIMIT_TIME
      end
    end

    def html_tag
      base_url = "https://lgtmoon.herokuapp.com/"
      try = 0
      begin
        try += 1
        image_id = rand(20000)
        conn = Faraday::Connection.new(:url => BASE_URL) do |builder|
          builder.use Faraday::Request::UrlEncoded
          builder.use Faraday::Response::Logger
          builder.use Faraday::Adapter::NetHttp
        end
        response = conn.get "images/#{image_id}" do |req|
          req.options.timeout = 10
        end
        if response.success?
          puts "<p align='center'><img src='#{BASE_URL}images/#{image_id}' alt='LGTM' /></p>"
        else
          if try >= RETRY_LIMIT_TIME
            puts "<p align='center'>LGTM</p>"
          end
          raise
        end
      rescue
        sleep(5)
        retry if try < RETRY_LIMIT_TIME
      end
    end
  end

end