# OurAirports Data Dictionary

{% docs raw_runways_data_dictionary %}

## Overview

This project uses open-data datasets published by [OurAirports](https://ourairports.com/). The authoritative OurAirports data dictionary is available at:

https://ourairports.com/help/data-dictionary.html

The source data is provided as UTF-8 comma-separated values (CSV). This project currently uses airport, runway, airport-frequency, country, navaid, region, and airport-comment datasets.

The descriptions below summarize the OurAirports data dictionary for the fields used by this project. The source website should be treated as the authoritative reference if the upstream dataset definition changes.

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

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
