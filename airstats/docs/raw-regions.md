# OurAirports Data Dictionary

{% docs raw_regions_data_dictionary %}

## Overview

This project uses open-data datasets published by [OurAirports](https://ourairports.com/). The authoritative OurAirports data dictionary is available at:

https://ourairports.com/help/data-dictionary.html

The source data is provided as UTF-8 comma-separated values (CSV). This project currently uses airport, runway, airport-frequency, country, navaid, region, and airport-comment datasets.

The descriptions below summarize the OurAirports data dictionary for the fields used by this project. The source website should be treated as the authoritative reference if the upstream dataset definition changes.

## Regions

The `regions.csv` dataset contains high-level administrative subdivisions of countries. `airports.iso_region` references `regions.code`.

| Field | Description |
|---|---|
| `id` | Persistent internal integer identifier for the region. |
| `code` | Globally unique region code consisting of the country code and local region code. |
| `local_code` | Local administrative-subdivision code. |
| `name` | Common English-language name of the subdivision. |
| `continent` | Continent code. |
| `iso_country` | Two-character country code for the containing country. |
| `wikipedia_link` | URL for the subdivision's Wikipedia page. |
| `keywords` | Comma-separated search terms associated with the subdivision. |

## Airport Comments

The project also loads the OurAirports airport-comments dataset. The current OurAirports data dictionary page identifies the dataset but does not provide a field-by-field dictionary for the comments export. The project therefore documents the fields according to the source export used by this pipeline:

| Field | Project usage |
|---|---|
| `id` | Unique identifier for the comment record. |
| `threadRef` | Comment thread reference. |
| `airportRef` | Internal airport reference. |
| `airportIdent` | Airport identifier associated with the comment. |
| `date` | Comment timestamp/date. |
| `memberNickname` | Contributor/member nickname. |
| `subject` | Comment subject. |
| `body` | Comment body text. |

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
