# activate virtual environment
source env/bin/activate

# run the api server
python epiviz.py &

# run the ui
cd epiviz
caddy