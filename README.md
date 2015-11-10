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

herokuの設定は、 vagrant 上でやる場合は
http://qiita.com/hirolog/items/eefda94756f547ea08f2
をみると設定がすぐにできる。

spec/spec_helper.rbじゃなくて、 spec/rails_helper.rbに config.include Capybara::DSL を追記する。

== 3章 演習
3.5.3
posgresql-server  postgresql postgresql-libs 辺りを yum で入れる  
http://lets.postgresql.jp/documents/tutorial/centos

# su - postgres
-bash-4.1$ createuser dev
Shall the new role be a superuser? (y/n) y
-bash-4.1$ logout

と、 postgresユーザになって、 devという(開発で使ってるユーザと同じ名前の)ユーザを作成し、
rake db:create  
rake db:migrate  
する
