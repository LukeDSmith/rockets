import click
from click.testing import CliRunner
from rockets import rockets

def test_rockets():
    runner = CliRunner()
    result = runner.invoke(rockets)
    assert result.exit_code == 0
    assert result.output == "blah"
