# Scripts Usage Information

## clean_csv.py

This is a small script that iterates through the a given inbox folder that contains the raw airport data csv files downloaded from our [data source](https://ourairports.com/data/). 

### Requirements

- Python >= 3.13
- Pandas >= 3.0.6

#### Notes

- This may work with older versions of Python 3.x and Pandas 2.x or 3.x but have been tested with these versions.

### Usage information

From `python scripts/clean_csv.py -h`:

```text
usage: Clean CSV files [-h] inbox outbox

Cleans csv files in a given inbox, and saves them to a given outbox.

positional arguments:
  inbox       Inbox folder with csv files to clean
  outbox      Output folder where cleaned csv files are saved

options:
  -h, --help  show this help message and exit
```

## Examples

Copy all csv files in an inbox located in the project root directory to the airstats/seeds directory:

Command:

```bash
python scripts/clean_csv.py ./inbox/ ./airstats/seeds/
```

Output:

```text
Cleaned CSV saved to: ./airstats/seeds/airport-comments.csv
Cleaned CSV saved to: ./airstats/seeds/airport-frequencies.csv
Cleaned CSV saved to: ./airstats/seeds/airports.csv
Cleaned CSV saved to: ./airstats/seeds/countries.csv
Cleaned CSV saved to: ./airstats/seeds/navaids.csv
Cleaned CSV saved to: ./airstats/seeds/regions.csv
Cleaned CSV saved to: ./airstats/seeds/runways.csv
```

## Additional Notes on DuckDB Implementation

### dbt-duckdb v1.11.0

- Installed with `pip install dbt-duckdb`
- This `clean_csv.py` script did not resolve all of the issues with these input files when running `dbt seed`.
- Error messages similar to this one would appear after running `dbt seed`:

```text
22:38:40  Completed with 1 error, 0 partial successes, and 0 warnings:
22:38:40
22:38:40  Failure in seed airports (seeds\airports.csv)
22:38:40    Runtime Error in seed airports (seeds\airports.csv)
  Invalid Input Error: CSV Error on Line: 2477
  Original Line:
  9090,26AR,small_airport,"Fly ""N"" K Airport",35.2154998779,-91.807800293,400.0,,US,US-AR,Searcy,no,,,26AR,26AR,,,
  Value with unterminated quote found.

  Possible fixes:
  * Disable the parser's strict mode (strict_mode=false) to allow reading rows that do not comply with the CSV standard.
  * Enable ignore errors (ignore_errors=true) to skip this row
  * Set quote to empty or to a different value (e.g., quote='')

    file = C:\Users\ryans\code\dbt-capstone-project\airstats\seeds\airports.csv
    delimiter = , (Set By User)
    quote = " (Auto-Detected)
    escape = (empty) (Auto-Detected)
    new_line = \r\n (Auto-Detected)
    header = true (Set By User)
    skip_rows = 0 (Auto-Detected)
    comment = (empty) (Auto-Detected)
    strict_mode = true (Auto-Detected)
    date_format =  (Auto-Detected)
    timestamp_format =  (Auto-Detected)
    null_padding = 0
    sample_size = 20480
    ignore_errors = false
    all_varchar = 0
  The Column types set by the user do not match the ones found by the sniffer.
  Column at position: 0 Set type: INTEGER Sniffed type: BIGINT
  Column at position: 6 Set type: INTEGER Sniffed type: DOUBLE
  Column at position: 11 Set type: VARCHAR Sniffed type: BOOLEAN
```

- A macro needed to be written to overwrite the dbt adapter for DuckDB because the adapter installed as `dbt-duckdb` via `pip` built the `COPY INTO` statement calling `read_csv` without passing `escape='"'` as a parameter. That macro is located at `./airstats/macros/seed.sql`. This macro may need to be edited to support other database types. Without this macro, `dbt-duckdb` adapter was not escaping using `"`, which is a CSV standard escape character. For example, a value with `"Google ""This search term"""` would throw an error, because the auto-detection did not parse the escape character. Another example in the `airports.csv` file was something like `"Fly ""N"" K Airport"`, where this does work with `read_csv('seeds/airports.csv, header=true, escape='"')` in DuckDB, but not with the default macro used by the installed adapter.
