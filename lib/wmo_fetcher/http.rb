# frozen_string_literal: true

require "net/http"
require "uri"

module WmoFetcher
  # Shared HTTP backend with a pluggable client (specs inject a stub).
  module Http
    class NetHttp
      def get(url, limit: 10)
        raise ArgumentError, "too many HTTP redirects" if limit.zero?

        uri = URI(url)
        resp = Net::HTTP.get_response(uri)
        case resp
        when Net::HTTPSuccess then resp.body
        when Net::HTTPRedirection then get(resp["location"], limit: limit - 1)
        else
          raise "HTTP #{resp.code} for #{url}"
        end
      end
    end

    class << self
      attr_accessor :backend

      def get(url, **opts)
        (backend || NetHttp).get(url, **opts)
      end
    end
  end
end
