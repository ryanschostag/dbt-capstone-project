# OurAirports Data Dictionary

{% docs bronze_runways_data_dictionary %}

## Overview

The bronze tables are from the tables in the raw schema.

## Runways

| Field | Description |
|---|---|
| `runway_id` | From raw `id`. Persistent internal integer identifier for the runway surface. |
| `airport_ident` | Externally visible airport identifier matching `airports.ident`. |
| `runway_length_ft` | From raw `length_ft`. Full runway-surface length, in feet. |
| `runway_width_ft` | From raw `width_ft`. Runway-surface width, in feet. |
| `runway_surface` | From raw `surface`. Code describing the runway surface type. |
| `runway_lighted` | From raw `lighted`. `1` when the surface is lighted at night; `0` otherwise. |
| `runway_closed` | From raw `closed`. `1` when the runway surface is currently closed; `0` otherwise. |

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
