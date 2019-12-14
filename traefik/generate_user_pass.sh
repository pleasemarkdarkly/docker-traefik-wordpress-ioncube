echo $(htpasswd -nbB admin "password") | sed -e s/\$/\$\$/g
