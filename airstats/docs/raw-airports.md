# OurAirports Data Dictionary

{% docs raw_airports_data_dictionary %}

## Overview

This project uses open-data datasets published by [OurAirports](https://ourairports.com/). The authoritative OurAirports data dictionary is available at:

https://ourairports.com/help/data-dictionary.html

The source data is provided as UTF-8 comma-separated values (CSV). This project currently uses airport, runway, airport-frequency, country, navaid, region, and airport-comment datasets.

The descriptions below summarize the OurAirports data dictionary for the fields used by this project. The source website should be treated as the authoritative reference if the upstream dataset definition changes.

## Airports

The `airports.csv` dataset contains one record for each airport. `id` is the internal OurAirports identifier, while `ident` is the externally visible identifier used to relate the airport to other OurAirports datasets.

| Field | Description |
|---|---|
| `id` | Persistent internal integer identifier for the airport. |
| `ident` | Text identifier used in the OurAirports URL; normally the ICAO code when available, otherwise a local or internally generated identifier. |
| `type` | Airport type. OurAirports defines values including `balloonport`, `closed_airport`, `heliport`, `large_airport`, `medium_airport`, `seaplane_base`, and `small_airport`. |
| `name` | Official airport name. |
| `latitude_deg` | Airport latitude in decimal degrees; positive values indicate north. |
| `longitude_deg` | Airport longitude in decimal degrees; positive values indicate east. |
| `elevation_ft` | Airport elevation above mean sea level, in feet. |
| `continent` | Two-letter continent code. |
| `iso_country` | Two-character country code associated with the airport. |
| `iso_region` | Code for the high-level administrative subdivision containing the airport. |
| `municipality` | Primary municipality served by the airport, when available. |
| `scheduled_service` | Indicates whether the airport currently has scheduled airline service. |
| `gps_code` | Airport code normally used by an aviation GPS database. |
| `icao_code` | Four-letter ICAO airport code, when available. |
| `iata_code` | Three-letter IATA airport code, when available. |
| `local_code` | Local airport code when different from the other airport-code fields. |
| `home_link` | URL for the airport's official website, when available. |
| `wikipedia_link` | URL for the airport's Wikipedia page, when available. |
| `keywords` | Comma-separated search terms associated with the airport. |

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
