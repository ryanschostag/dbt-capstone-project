"""
pytest module for clean_csv.py script
"""
import pytest
import clean_csv as cc


@pytest.mark.parametrize(
    "input_value, expected_output",
    [
        ('""value""', 'value'),
        ('"""value"""', 'value'),
        ('value', 'value'),
        ('"value', 'value'),
        ('value"', 'value'),
        (" ""airportRef", "airportRef")
    ]
)
def test_remove_trailing_and_leading_double_quotes_or_spaces(input_value, expected_output):
    assert cc.remove_trailing_and_leading_double_quotes_or_spaces(input_value) == expected_output
