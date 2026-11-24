# frozen_string_literal: true

require "pubid"

module WmoFetcher
  # The record identifier: a Pubid::Wmo identifier. Never hand-parse —
  # the grammar is the SSOT (pubid#763 + the widening round).
  Docid = ::Pubid::Wmo::Identifier
end
