# OurAirports Data Dictionary

{% docs silver_airports_data_dictionary %}

## Overview

The silver tables are based on the bronze tables, which in turn are from the tables in the raw schema.

## Airports

| Field | Description |
|---|---|
| `airport_ident` | From raw `ident`. Text identifier used in the OurAirports URL; normally the ICAO code when available, otherwise a local or internally generated identifier. |
| `airport_type` | From raw `type`. Airport type. OurAirports defines values including `balloonport`, `closed_airport`, `heliport`, `large_airport`, `medium_airport`, `seaplane_base`, and `small_airport`. |
| `airport_name` | From raw `name`. Official airport name. |
| `airport_lat` | From raw `latitude_deg`. Airport latitude in decimal degrees; positive values indicate north. |
| `airport_long` | From raw `longitude_deg`. Airport longitude in decimal degrees; positive values indicate east. |
| `continent` | Two-letter continent code. |
| `iso_country` | Two-character country code associated with the airport. |
| `iso_region` | Code for the high-level administrative subdivision containing the airport. |

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
