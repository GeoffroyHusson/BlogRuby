# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create :email => 'cestunexmple@test.be',
					:password => 'secret',
					:password_confirmation => 'secret'

Category.create [{:name => 'programming'},
					{:name => 'Event'},
					{:name => 'Travel'},
					{:name => 'Music'},
					{:name => 'TV'}]

user.articles.create :title => 'Advance Active Record',
					:body => 'Ceci est le texte du body.'
					:published_at => Date.today

user.articles.create :title => 'Titre que voici',
					:body => 'Voici le texte il est long long long ou pas ..'
					:published_at => Date.today

user.articles.create :title => 'Encore !',
					:body => "C''est le dernier."
					:published_at => Date.today

					