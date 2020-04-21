# setup a virtual environment
virtualenv env
source env/bin/activate

# install the package
pip install epivizfileserver

# install the ui dependencies
cd epiviz
bower install