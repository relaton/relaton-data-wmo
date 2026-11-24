# relaton-data-wmo

Relaton bibliographic records for **World Meteorological Organization (WMO)** documents:
the WMO-No. series (technical regulations and guides), WMO/TD technical documents,
JCOMM technical reports, GAW reports, and WMO-published S-100 product specifications.

Identifier semantics live in [`Pubid::Wmo`](https://github.com/metanorma/pubid)
(pubid#763 and the widening round: volume faces, compound editions, the series heads).

## Sources

- [WMO e-Library](https://library.wmo.int/) (i2s Limb Gallery). OAI-PMH is exposed at
  `https://library.wmo.int/oai` but its harvest verbs (`ListRecords`/`ListIdentifiers`)
  are broken server-side (HTTP 500) and the DC payload is title-only; item pages and
  PDFs sit behind an ALTCHA proof-of-work gate. See the population issue for the
  working strategy (community.wmo.int hub seed + gated walk; vendor contact for the
  OAI fix).
- [WMO Knowledge Hub](https://community.wmo.int/) — ungated edition listings per series.

## Layout

- `data/` — one YAML record per document, Relaton shape, keyed by `Pubid::Wmo` ids.
- `lib/wmo_fetcher/` — the crawler (Sources architecture, as relaton-data-adobe).
- `index-v2.yaml` — the pubid machine index built from `data/` on each crawl.

Workflows (Deploy/Check index/Crawler/keep-alive/api-ingest) are Cimas-synced
from relaton/support.
