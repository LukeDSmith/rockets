import requests
import json
import textwrap
import click
import logging

@click.command()
@click.option('--rocket_id', default="falcon9", type=click.Choice(["falcon1", "falcon9", "falconHeavy", "bfr"]), help="ID of the Rocket")
@click.option('--year', default=2017,type=int, help="Year of launches to search through")
def rockets(year, rocket_id):
    """CLI tool that returns launch data when given a valid RocketID and Year \n Valid Rockets: falcon1, falcon9, falconHeavy, bfr"""
    logging.basicConfig(filename='rockets.log', level=logging.INFO, format='%(asctime)s:%(levelname)s:%(message)s')
    r = requests.get("https://api.spacexdata.com/v2/launches?launch_year={0}&rocket_id={1}".format(year, rocket_id))
    logging.info("Requesting data for rocket {0} on year {1}".format(rocket_id, year))
    logging.info("Time taken: {0}".format(requests.get("https://api.spacexdata.com/v2/launches?launch_year={0}&rocket_id={1}".format(year, rocket_id)).elapsed.total_seconds()))
    data = json.loads(r.text)
    if len(data) is 0:
       click.echo("No data was found for rocket: {0} in the year {1}".format(rocket_id, year))
    else:
       for i in range(len(data)):
           click.echo("\n")
           click.echo("Launch entry: {}".format(i+1))
           click.echo("Rocket name: {}".format(json.dumps(data[i]["rocket"]["rocket_name"])))
           click.echo("Local launch time: {}".format(json.dumps(data[i]["launch_date_local"])))
           click.echo("Launch site: {}".format(json.dumps(data[i]["launch_site"]["site_name_long"])))
           click.echo("Details: {}".format(textwrap.fill(json.dumps(data[i]["details"]), 150)))
