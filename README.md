# docker-traefik-wordpress-iocube

This repo contains docker-compose.yml files to quickly get up to speed with a Traefik 2.0 reverse proxy and staging and production Wordpress website. Some knowledge of Docker build and Traefik basic configuration is needed, however, the compose files are complete and have been used for some time. The Wordpress subdomains have multiple hosts entries. Detailed instructions are not included, but general high-level todos are as follows.

## Traefik 2.0

I'll use some pseudo code / general helpers on the process. Replace pico with whichever editor you love.

### Getting Traefik 2.0 Running
```
cd traefik
chmod +x generate_user_pass.sh
pico generate_user_pass.sh
# replace password in 'echo $(htpasswd -nbB admin "password") | sed -e s/\$/\$\$/g' with something
./generate_user_pass.sh
# copy and paste the output to
pico ./docker-compose.yml
# replace [output-of-generate-password]
# while in this file, update the domains you want to use and remove the extra host entry if its not needed
cd data
pico traefik.yml
# replace email with yours
chmod 600 acme.json
cd ..
docker-compose up
```

## SMTP

In order for Wordpress or any other application to send mail, it is necessary to give them access to SMTP container. Using the container name is sufficient for the host in Wordpress. I've included a seperate docker-compose file, however, including it in the Wordpress docker-compose.yml depending on Wordpress is not a bad idea. 

## Building Wordpress Ion-cube (Staging/Production)

This build of Wordpress uses the latests 5.3.1 and PHP version 7.3.12. You may dive into the subdirectory staging.wordpress/wp_docker and edit the build.yml and Dockerfile to change the Wordpress version to anything you need.

```
cd staging.wordpress
# You may just build the Dockerfile here
docker build -t wordpress-ioncube:latest .
# or replace the 'image: wordpress-ioncube:latest' to 'build .' in the docker-compose file
# otherwise after you build your local docker image
pico docker-compose up -d 
# replace passwords, hostnames
docker-compose up -d
```

Doing the same with production except you can just use your local version of the built wordpress-ioncube:latest. This image was built to handle Symbiostock with a Social Media plugin called Social Rabbit, so this has all the components you may need to build your stock/vector store with the various plugins and subsequent marketing through social media. 



