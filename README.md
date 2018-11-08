### Welcome to OneBox

The purpose of this is to simplify Magento Development. Contained herein is a simplified Magento 2 installation.

To install clone the repo down then follow the steps below:

## This assumes you have Docker installed if not visit https://docs.docker.com/install/

1. Edit .env file
    * Change the SERVER_NAME & SERVER_ALIAS to match your website name or leave in test data
2. Add the SERVER_NAME and SERVER_ALIAS to your host machine /etc/hosts file
3. Run setup.sh
4. Navigate to SERVER_NAME in your web browser you should see a PHP Info

Now that is handy. However, no real development is being done here or even the foundation. To work on a site: 

1. Clone the repo into the src/ folder.
2. To import the database in GZIP format run ./import path_to_sql_dump
3. run ./cleanup
4. Navigate to the URL in your browser, you should now see your development site

#### APPENDIX Of Scripts
0. setup.sh
    * This command is run the very first time
1. start
    * This command starts the docker container
2. stop
    * This command stops the container but leaves the data intact
3. kill
    * This command destroys the container
    * To wide out the db as well run the following
        * rm -rf docker/services/mysql/data/*
4. cleanup
    * This will run the m2_cleaning_script.sql on the mysql db
5. composer
    * This will run composer inside the container
6. import
    * This will import a GZIP sql file into the container db
7. magerun
    * This will run n98 magerun inside the container
8. mysql
    * THis will give you a CLI mysql prompt into the container
9. shell
    * This will give you a shell into the container
10. vhosts
    * This will create vhosts using the .env file
11. xdebug
    * This will run Xdebug
