# Installation

To get and build the environment, do:

    git clone https://github.com/klavins/pyedw.git
    cd pyedw
    docker build -t pyedw .

# Running

To connect to the EDW from off campus, you should first install and run the UW VPN via https://itconnect.uw.edu/connect/uw-networks/about-husky-onnet/. 

Next, to start jupyter, do:

    docker run -v "$PWD":/home/jovyan/work -p 8888:8888 pyedw 

This will print out a link to the jupyter server, which you should open in your browser.

Finally, you should be able to open examples/basics.ipynb and run the notebook. 

