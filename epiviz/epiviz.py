from epivizfileserver import setup_app, create_fileHandler, MeasurementManager
from epivizfileserver.trackhub import TrackHub
import os

if __name__ == "__main__":
    # create measurements to load multiple trackhubs or configuration files
    mMgr = MeasurementManager()

    # create file handler, enables parallel processing of multiple requests
    mHandler = create_fileHandler()

    # add genome. - for supported genomes 
    # check https://obj.umiacs.umd.edu/genomes/index.html
    genome = mMgr.add_genome("mm10")

    # load ATAC trackhub
    th1 = TrackHub(<ADD_TRACKHUB_URL>)
    for m in th1.measurements:
        m.filehandler = mHandler
        mMgr.measurements.append(m)

    # setup the app from the measurements manager 
    # and run the app
    app = setup_app(mMgr)
    app.run(host="0.0.0.0", port=8000)