# Installation

To build the environment, do:

    docker build -t pyedw .

To connect to the EDW from off campus, you should first install the UW VPN via https://itconnect.uw.edu/connect/uw-networks/about-husky-onnet/. 

Next, to run a notebook server, do:

    docker run -v "$PWD":/home/jovyan/work -p 8888:8888 pyedw 

This will print out a link to the notebook server, which you should open in your browser.

Then, from within Jupyter, open a terminal and run

    kinit username

where username is your uw net id. 

Finally, you should be able to open examples/basics.ipynb and run the notebook. 
