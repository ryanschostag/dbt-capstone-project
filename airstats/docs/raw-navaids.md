# OurAirports Data Dictionary

{% docs raw_navaids_data_dictionary %}

## Overview

This project uses open-data datasets published by [OurAirports](https://ourairports.com/). The authoritative OurAirports data dictionary is available at:

https://ourairports.com/help/data-dictionary.html

The source data is provided as UTF-8 comma-separated values (CSV). This project currently uses airport, runway, airport-frequency, country, navaid, region, and airport-comment datasets.

The descriptions below summarize the OurAirports data dictionary for the fields used by this project. The source website should be treated as the authoritative reference if the upstream dataset definition changes.

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

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
