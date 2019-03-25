#!/usr/bin/env ruby
require 'rubygems'
require 'gollum/auth'
require 'gollum/app'


# Generate SHA256 hash
# require 'digest'
# Digest::SHA256.hexdigest "your_string"

users = YAML.load %q{
---
- username: lidashuang
  password_digest: 8721d1333b764926ff121fed87539c492af07cc3930258752fc3a26b33a91cd8
  name: lidashuang
  email: ldshuang@gmail.com
}

options = { allow_unauthenticated_readonly: true }
use Gollum::Auth, users, options

gollum_path = File.expand_path(File.dirname(__FILE__)) # CHANGE THIS TO POINT TO YOUR OWN WIKI REPO
wiki_options = {
  universal_toc: false,
  live_preview: false
}

Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:default_markup, :markdown) # set your favorite markup language
Precious::App.set(:wiki_options, wiki_options)
run Precious::App