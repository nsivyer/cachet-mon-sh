#Overview

A lot of the Cachet metric plugins are very bulky. I just wanted something quick and simple to push stats into the metric API.


#Installation

copy the files some place. 

    cd /opt/
    git clone https://github.com/nsivyer/cachet-mon-sh.git /opt/
 
configure you first end piont

    cd /opt/cachet-mon-sh
    vim ex-example

run manually to test

    sh -x run.sh

add to cron

    echo '* * * * * root /opt/cachet-mon-sh/run.sh > /dev/null' > /etc/cron.d/cachet-mon-sh


