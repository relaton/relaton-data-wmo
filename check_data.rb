# frozen_string_literal: true

# Round-trips every data/*.yaml through the Wmo flavor model — a record
# that will not parse back is a defect the crawl should catch.
require "bundler/setup"
require "relaton"

Dir["data/*.yaml"].sort.each do |f|
  Relaton::Wmo::Item.from_yaml(File.read(f, encoding: "UTF-8"))
  puts "ok #{f}"
rescue StandardError, LoadError => e
  warn "FAIL #{f}: #{e.class}: #{e.message[0, 80]}"
end
