== README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

== 3章

config/initializers/secret_token.rb はないから新規作成  
rails generate rspec:installが動かないから
Gemfile に 
  gem 'therubyracer', platforms: :ruby
を追加し、bundle install して サイド rspec:installを実行
