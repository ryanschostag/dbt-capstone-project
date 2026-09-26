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

## Testing

Use pytest to run tests against the script.

Example test command:

```bash
pytest -q ./scripts/test_clean_csv.py
```

Example output:

```text
.....                            [100%]
5 passed in 0.45s
```

Use your preferred `pytest` options.
