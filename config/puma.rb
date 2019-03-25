threads 1, 6
workers 2

bind "unix:///var/run/gollum/puma.sock"

preload_app!
