Epiviz is an interactive data visualization and exploration tool for functional genomic data. Epiviz interactively queries and can apply transformations over data in a given genomic region directly over files. 

To visualize genomic data using Epiviz, we need to setup the backend and the user interface

## Requirements

- Python, using a virtualenv/conda is recommended.
- Bower, Install bower from http://bower.io/
- Caddy, Install caddy from http://caddyserver.com/


## Setup API backend

1. Setup a python virtual environment using virtualenv or conda
2. Install the epivizfileserver python package through pip

        > pip install epivizfileserver

3. Use the script `epiviz.py` to setup the API for trackhub repositories. Our [documentation site](https://epivizfileparser.readthedocs.io/en/latest/) contains additional information on setting up the API for publicly available files and repositories.


## Setup Frontend 

1. We use [bower](https://bower.io/) to install dependencies

        > bower install

2. update API endpoint in `epiviz/index.html`

3. Use caddy or any other tool to run a webserver. 

        > caddy

3. Open browser and go to http://localhost:2015/

    Note: Caddy usually runs on port 2015, but check the terminal prompt for the port number and update this url.


## Helpful scripts
we also provide two scripts to easily setup this process


- `epiviz_install.sh` that install dependencies for both the backend and the user interface
- `epiviz_run.sh` runs the backend and the frontend interface

    Note: make sure to add trackhub urls in `epiviz.py`