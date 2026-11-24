# relaton-data-wmo

Bibliographic records for WMO documents, keyed by Pubid::Wmo ids. The
crawler never hand-parses identifiers — the grammar (pubid#763 + the
widening round) is the SSOT; a link that does not parse is data for the
parse-improvement round, not a record (the machine index cannot carry
unparseable ids — relaton#604 makes the build fail on them).

## Conventions

- One YAML record per document in `data/`, Relaton shape, `id:` is the
  parseable Pubid::Wmo form; the docidentifier carries the citation
  string.
- The Indexer parses each record's `id` for index-v2 — run Crawler
  before Deploy (the Deploy build falls back to the committed index;
  a Deploy without a prior Crawler rebuild publishes stale rows), then
  re-dispatch the API ingest (the push trigger races the rebuild; the
  Deploy-completion trigger corrects it).
- The e-Library item pages sit behind an ALTCHA gate; this repo's
  sources never hit the gate. Ungated: the Knowledge Hub seed pages.
  See the population issue.
