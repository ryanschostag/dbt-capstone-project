# OurAirports Data Dictionary

{% docs raw_countries_data_dictionary %}

## Overview

This project uses open-data datasets published by [OurAirports](https://ourairports.com/). The authoritative OurAirports data dictionary is available at:

https://ourairports.com/help/data-dictionary.html

The source data is provided as UTF-8 comma-separated values (CSV). This project currently uses airport, runway, airport-frequency, country, navaid, region, and airport-comment datasets.

The descriptions below summarize the OurAirports data dictionary for the fields used by this project. The source website should be treated as the authoritative reference if the upstream dataset definition changes.

## Countries

The `countries.csv` dataset contains country and country-like entities.

| Field | Description |
|---|---|
| `id` | Persistent internal integer identifier for the country record. |
| `code` | Two-character country code. |
| `name` | Common English-language country name. |
| `continent` | Continent code. |
| `wikipedia_link` | URL for the country's Wikipedia page. |
| `keywords` | Comma-separated search terms associated with the country. |

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
