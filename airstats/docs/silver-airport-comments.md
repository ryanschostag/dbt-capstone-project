# OurAirports Data Dictionary

{% docs silver_airport_comments_data_dictionary %}

## Overview

The silver tables are based on the bronze tables, which in turn are from the tables in the raw schema.

## Airport Comments

| Field | Project usage |
|---|---|
| `comment_id` | From raw `id`. Unique identifier for the comment record. |
| `airport_ident` | From raw `airportIdent`. Airport identifier associated with the comment. |
| `comment_timestamp` | From raw `date`. Comment timestamp/date. |
| `member_nickname` | From raw `memberNickname`. Contributor/member nickname. |
| `comment_subject` | From raw `subject`. Comment subject. |
| `comment_body` | From raw `body`. Comment body text. |
| `loaded_at` | Metadata field for the time the record was loaded into the table. |

## Source

OurAirports, "Dataset formats / Data dictionary," https://ourairports.com/help/data-dictionary.html

{% enddocs %}
