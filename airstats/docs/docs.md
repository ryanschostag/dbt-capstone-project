# OurAirports Data Dictionary

{% docs ourairports_data_dictionary %}

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

## Runways

The `runways.csv` dataset contains one record for each airport landing surface, including runways, helipads, and waterways. Fields without an `le_` or `he_` prefix describe the entire surface. `le_` fields describe the low-numbered end and `he_` fields describe the high-numbered end.

| Field | Description |
|---|---|
| `id` | Persistent internal integer identifier for the runway surface. |
| `airport_ref` | Internal airport identifier matching `airports.id`. |
| `airport_ident` | Externally visible airport identifier matching `airports.ident`. |
| `length_ft` | Full runway-surface length, in feet. |
| `width_ft` | Runway-surface width, in feet. |
| `surface` | Code describing the runway surface type. |
| `lighted` | `1` when the surface is lighted at night; `0` otherwise. |
| `closed` | `1` when the runway surface is currently closed; `0` otherwise. |
| `le_ident` | Identifier for the low-numbered end of the runway. |
| `le_latitude_deg` | Latitude of the low-numbered runway end, in decimal degrees, when available. |
| `le_longitude_deg` | Longitude of the low-numbered runway end, in decimal degrees, when available. |
| `le_elevation_ft` | Elevation above mean sea level of the low-numbered runway end, in feet. |
| `le_heading_degT` | True heading of the low-numbered runway end, in degrees. |
| `le_displaced_threshold_ft` | Displaced-threshold length for the low-numbered runway end, when applicable. |
| `he_ident` | Identifier for the high-numbered end of the runway. |
| `he_latitude_deg` | Latitude of the high-numbered runway end, in decimal degrees, when available. |
| `he_longitude_deg` | Longitude of the high-numbered runway end, in decimal degrees, when available. |
| `he_elevation_ft` | Elevation above mean sea level of the high-numbered runway end, in feet. |
| `he_heading_degT` | True heading of the high-numbered runway end, in degrees. |
| `he_displaced_threshold_ft` | Displaced-threshold length for the high-numbered runway end, when applicable. |

## Airport Frequencies

The `airport-frequencies.csv` dataset contains radio communication frequencies associated with airports. `airport_ident` references `airports.ident`.

| Field | Description |
|---|---|
| `id` | Persistent internal integer identifier for the frequency record. |
| `airport_ref` | Internal airport identifier matching `airports.id`. |
| `airport_ident` | Externally visible airport identifier matching `airports.ident`. |
| `type` | Frequency type, such as tower, ground, ATIS, or UNICOM. |
| `description` | Description of the frequency. |
| `frequency_mhz` | Radio voice frequency in megahertz. |

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

## Navaids

The `navaids.csv` dataset contains radio navigation aids. When applicable, `associated_airport` references `airports.ident`.

| Field | Description |
|---|---|
| `id` | Persistent internal integer identifier for the navaid. |
| `filename` | Unique string identifier used in the OurAirports URL. |
| `ident` | One- to three-character identifier transmitted by the navaid. |
| `name` | Navaid name, excluding its type. |
| `type` | Navaid type, such as `DME`, `NDB`, `VOR`, or `VORTAC`. |
| `frequency_khz` | Navaid frequency in kilohertz. |
| `latitude_deg` | Navaid latitude in decimal degrees. |
| `longitude_deg` | Navaid longitude in decimal degrees. |
| `elevation_ft` | Navaid elevation above mean sea level, in feet. |
| `iso_country` | Two-character country code for the navaid operator. |
| `dme_frequency_khz` | Paired DME/VHF frequency in kilohertz when applicable. |
| `dme_channel` | DME channel when available. |
| `dme_latitude_deg` | Associated DME latitude, in decimal degrees. |
| `dme_elevation_ft` | Associated DME elevation above mean sea level, in feet. |
| `slaved_variation_deg` | Magnetic variation adjustment built into applicable VOR/DME/TACAN radials. |
| `magnetic_variation_deg` | Actual magnetic variation at the navaid location. |
| `usageType` | Primary function of the navaid in the airspace system. |
| `power` | Navaid power-output level. |
| `associated_airport` | OurAirports airport identifier for an associated airport. |

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
