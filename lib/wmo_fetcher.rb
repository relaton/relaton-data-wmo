# frozen_string_literal: true

module WmoFetcher
  autoload :Docid,        "#{__dir__}/wmo_fetcher/docid"
  autoload :SourceEntry,  "#{__dir__}/wmo_fetcher/source_entry"
  autoload :Sources,      "#{__dir__}/wmo_fetcher/sources"
  autoload :Http,         "#{__dir__}/wmo_fetcher/http"
end
