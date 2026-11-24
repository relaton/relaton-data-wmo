# frozen_string_literal: true

# The daily crawl. Population strategy lives in the repo's population
# issue; until the gated e-Library walk lands, this run enumerates the
# ungated Knowledge Hub seed and rebuilds the index from data/.
require_relative "lib/wmo_fetcher"
require "relaton"
require "relaton/wmo" if File.exist?("lib/relaton/wmo")

puts "relaton-data-wmo crawler: population pending (see the population issue)"
