# frozen_string_literal: true

require "nokogiri"

module WmoFetcher
  module Sources
    # The ungated seed source: the WMO Knowledge Hub (community.wmo.int,
    # Drupal) lists editions with years and e-Library links per series —
    # the WMO-No. 8 page and the GAW/JCOMM report pages are the worked
    # examples. This source walks those hub pages and yields entries for
    # every edition link it can parse into a Pubid::Wmo id.
    #
    # The gated full crawl (library.wmo.int item pages, ALTCHA-proofed)
    # and the OAI-PMH vendor fix are tracked in the repo's population
    # issue; this source never hits the gate.
    class KnowledgeHub < WmoFetcher::Sources::Base
      HUB_PAGES = [
        "https://community.wmo.int/site/knowledge-hub/programmes-and-initiatives/" \
        "global-atmosphere-watch-gaw-programme/gaw-reports",
      ].freeze

      # Hub page anchor hrefs that point at the e-Library record for an
      # edition. Subclasses/sources refine; the seed pass only records
      # what it can already key on a Pubid::Wmo parse.
      def each_entry
        return enum_for(:each_entry) unless block_given?

        HUB_PAGES.each do |page|
          body = WmoFetcher::Http.get(page)
          Nokogiri::HTML(body).css("a[href*='library.wmo.int']").each do |a|
            id = parse_link(a.text, a[:href])
            yield SourceEntry.new(id: id, web_url: a[:href]) if id
          end
        end
      end

      private

      # A link is an entry only when its text or URL carries a WMO id the
      # grammar reads ("GAW Report No. 234", "WMO-No. 8", "WMO/TD-No. 1551").
      # Unparseable links are data for the parse-improvement round, not
      # records — the machine index cannot carry them anyway (relaton#604).
      def parse_link(text, href)
        [text, href].filter_map do |candidate|
          begin
            ::Pubid::Wmo.parse(candidate.to_s)
          rescue StandardError
            nil
          end
        end.first
      end
    end
  end
end
