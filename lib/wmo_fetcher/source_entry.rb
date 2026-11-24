# frozen_string_literal: true

module WmoFetcher
  # Common entry shape for every Source: the parsed Pubid::Wmo id plus the
  # optional location fields. Series-specific Sources build these.
  class SourceEntry
    attr_reader :id, :title, :date, :web_url, :bytes_url

    def initialize(id:, title: nil, date: nil, web_url: nil, bytes_url: nil)
      @id = id
      @title = title
      @date = date
      @web_url = web_url
      @bytes_url = bytes_url
    end

    def to_docid
      @id
    end
  end
end
