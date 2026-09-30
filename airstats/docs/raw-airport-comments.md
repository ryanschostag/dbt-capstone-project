# OurAirports Data Dictionary

{% docs raw_airport_comments_data_dictionary %}

## Overview

This project uses open-data datasets published by [OurAirports](https://ourairports.com/). The authoritative OurAirports data dictionary is available at:

https://ourairports.com/help/data-dictionary.html

The source data is provided as UTF-8 comma-separated values (CSV). This project currently uses airport, runway, airport-frequency, country, navaid, region, and airport-comment datasets.

The descriptions below summarize the OurAirports data dictionary for the fields used by this project. The source website should be treated as the authoritative reference if the upstream dataset definition changes.

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
