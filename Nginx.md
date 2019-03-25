## conf example 

gollum config

```
upstream gollum {
  server unix:///var/run/gollum/puma.sock;
}

server {
  listen 80;
  server_name wiki.dsh.li; # change to match your URL
  root /home/ldshuang/gollum_wiki/; # I assume your app is located at this location

  location / {
    proxy_pass http://gollum; # match the name of upstream directive which is defined above
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
 }
```

# nginx rails puma https 

	upstream center {
	  server unix:/data/deploy/center/shared/tmp/sockets/puma.sock fail_timeout=0;
	}
	
	## HTTPS host
	server {
	  listen 0.0.0.0:80 default_server;
	  listen 0.0.0.0:443 ssl default_server;
	  server_name center.3pjgames.com center-1.u.3pjgames.com "";
	  server_tokens off; ## Don't show the nginx version number, a security best practice
	  root /data/deploy/center/current/public;
	
	  ## Increase this if you want to upload large attachments
	  ## Or if you want to accept large git objects over http
	  client_max_body_size 20m;
	
	  # access_log  /var/log/nginx/gitlab_access.log;
	  access_log  off;
	  error_log   /var/log/nginx/center_error.log;
	
	  location / {
	    ## Serve static files from defined root folder.
	    ## @gitlab is a named location for the upstream fallback, see below.
	    try_files $uri $uri/index.html $uri.html @center;
	  }
	
	  ## If a file, which is not found in the root folder is requested,
	  ## then the proxy passes the request to the upsteam (gitlab unicorn).
	  location @center {
	    ## If you use HTTPS make sure you disable gzip compression
	    ## to be safe against BREACH attack.
	    gzip off;
	
	    ## https://github.com/gitlabhq/gitlabhq/issues/694
	    ## Some requests take more than 30 seconds.
	    proxy_read_timeout      300;
	    proxy_connect_timeout   300;
	    proxy_redirect          off;
	
	    proxy_set_header    Host                $http_host;
	    proxy_set_header    X-Real-IP           $remote_addr;
	    proxy_set_header    X-Forwarded-Ssl     on;
	    proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
	    proxy_set_header    X-Forwarded-Proto   $scheme;
	    proxy_set_header    X-Frame-Options     SAMEORIGIN;
	
	    proxy_pass http://center;
	  }
	
	  ## Enable gzip compression as per rails guide:
	  ## http://guides.rubyonrails.org/asset_pipeline.html#gzip-compression
	  ## WARNING: If you are using relative urls remove the block below
	  ## See config/application.rb under "Relative url support" for the list of
	  ## other files that need to be changed for relative url support
	  location ~ ^/(assets)/ {
	    root /data/deploy/center/current/public;
	    gzip_static on; # to serve pre-gzipped version
	    expires max;
	    add_header Cache-Control public;
	  }
	
	  error_page 502 /502.html;
	}





