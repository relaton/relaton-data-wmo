# frozen_string_literal: true

require "spec_helper"
require "wmo_fetcher"
require "pubid"
require "nokogiri"

RSpec.describe WmoFetcher::Sources::KnowledgeHub do
  let(:hub_html) do
    <<~HTML
      <html><body>
        <a href="https://library.wmo.int/records/item/58491-gaw-report-no-234">GAW Report No. 234</a>
        <a href="https://library.wmo.int/records/item/68660-guide">Guide to Instruments and Methods</a>
        <a href="https://library.wmo.int/records/item/1000-unrelated">WMO Annual Report</a>
      </body></html>
    HTML
  end

  before do
    allow(WmoFetcher::Http).to receive(:get).and_return(hub_html)
  end

  it "yields entries whose links parse as Pubid::Wmo ids" do
    entries = described_class.new.each_entry.to_a
    expect(entries.length).to eq(1)
    expect(entries.first.id.to_s).to eq("GAW Report No. 234")
  end
end
