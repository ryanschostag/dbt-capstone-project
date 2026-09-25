"""
Cleans a csv file from command line input
"""
import os
import argparse
import pandas as pd


class InvalidDirectoryError(FileNotFoundError):
    pass


def options():
    arg_parser = argparse.ArgumentParser(
        prog='Clean CSV files',
        description='Cleans csv files in a given inbox, and saves them to a given outbox.'
    )
    arg_parser.add_argument('inbox', help='Inbox folder with csv files to clean')
    arg_parser.add_argument('outbox', help='Output folder where cleaned csv files are saved')
    return arg_parser


def remove_trailing_and_leading_double_quotes(value: str) -> str:
    if isinstance(value, str):
        while value.startswith('"') and value.endswith('"'):
            return value[1:-1]
    return value


def clean_csv(input_file, output_file) -> None:
    """
    Addresses the following discovered concerns that prevented dbt seed from
    successfully loading the csv files provided by the data source:

    1. Removes spacing between field names in the csv header row
    2. Removes leading and trailing double quotes from all field values 
       (e.g. \"\"\"value\"\"\" caused an error)
    
    """
    csv_df = pd.read_csv(input_file)

    for column in csv_df.columns:
        csv_df[column] = csv_df[column].apply(
            remove_trailing_and_leading_double_quotes
        )

    csv_df.to_csv(output_file, index=False)
    print(f'Cleaned CSV saved to: {output_file}')


def main(inbox, outbox) -> None:
    """
    Entry point function for clean_csv.py module
    """
    for file_name in os.listdir(inbox):
        if file_name.endswith('.csv'):
            input_file = os.path.join(inbox, file_name)
            output_file = os.path.join(outbox, file_name)
            clean_csv(input_file, output_file)


if __name__ == "__main__":
    cmd_line = options()
    args = cmd_line.parse_args()

    if not os.path.isdir(args.inbox):
        raise InvalidDirectoryError(f'Inbox folder is invalid: {args.inbox}')

    if not os.path.isdir(args.outbox):
        raise InvalidDirectoryError(f'Outbox folder is invalid: {args.outbox}')

    main(args.inbox, args.outbox)
