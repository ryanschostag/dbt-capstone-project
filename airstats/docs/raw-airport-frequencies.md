# OurAirports Data Dictionary

{% docs raw_airport_frequencies_data_dictionary %}

## Overview

This project uses open-data datasets published by [OurAirports](https://ourairports.com/). The authoritative OurAirports data dictionary is available at:

https://ourairports.com/help/data-dictionary.html

The source data is provided as UTF-8 comma-separated values (CSV). This project currently uses airport, runway, airport-frequency, country, navaid, region, and airport-comment datasets.

The descriptions below summarize the OurAirports data dictionary for the fields used by this project. The source website should be treated as the authoritative reference if the upstream dataset definition changes.

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

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
