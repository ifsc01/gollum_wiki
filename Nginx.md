# conf example 

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