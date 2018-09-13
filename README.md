# rockets

Here is my submission for JustParks technical assignment

## Prerequisites

* ansible
* docker
* python
* pip

## Usgae

To execute the cli automation simply run the
`rocket-wrapper.sh`
With elevated privileges (sudo user)

## Implimentation Details

### CLI

The CLI itself utilises two packages Click and Requests.

The request module is used to make RESTful calls against API's and has a lot of utility. Our use is pretty simple. We construct a GET request using parsed paramters to hit the API, varibalise the JSON reponse for pretty print and log the latency of the request.

Click is what turns this python program into a CLI tool and comprises of two parts. The setup file and main. In the main options are defined as decorators and auto generate the --help function and also parametised to only accept certain inputs

In setup we define some basic metadata such as versions and names but also provide dependencies. The entry point functions similarly to Docker, in that this is where the command starts execution when invoked.

### Docker

Docker was chosen as my platform due its lightweight nature. The Dockerfile itself details the process of what is installed and the order of execution.
The main thing of note is that the Dockerfile is used to configure the logrotate requirement and follows these steps:

1. Make the /var/log direcotry the CLI will be writing to
2. Install logrotate
3. Copy the configuration into /etc/logrotate.d/

### Ansible

Ansible has been given the role of orchestrator in this assignment. The focus is the use of two modules: docker_image and docker_container these are used to automate (locally):

* Construction of a docker image based on the Dockerfile
* Instantiating a docker container
* Running test commands from within the container

## Expected Output

Upon running the wrapper script you should see ansible begin to execute its tasks. You should see:

1. Output for a API query of falcon9 in 2016
2. Output for non-existent launch data
3. The response when incorrect data types are passed to the options
4. The rockets_cli --help menu
5. Logged events of the first 2 queries

## Notes

The container named "rockets_cli" is left running after ansible is done executing. So further interation can be performed. To do this  either run:

`sudo docker exec -it rockets_cli rockets --rocket_id=<id> --year=<year>`
from your current terminal to further query the CLI

Or
`sudo docker exec -it --tty rockets_cli /bin/sh`
To open up an interactive shell with the container so you can go digging around if you so desire.

Thanks for reading :)
