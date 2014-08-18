# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
15.times do |a|
Post.create(title:"Hello World #{a}",content:"Goodbye #{a}",user_id:"1")
end
1.upto(6) do |x|
	CategoryPost.create(post_id:"#{x}", category_id:"1")
end
1.upto(6) do |x|
	CategoryPost.create(post_id:"#{x}", category_id:"2")
end
7.upto(10) do |x|
	CategoryPost.create(post_id:"#{x}", category_id:"2")
end
11.upto(15) do |x|
	CategoryPost.create(post_id:"#{x}", category_id:"3")
end
11.upto(15) do |x|
	CategoryPost.create(post_id:"#{x}", category_id:"4")
end

4.times do |x|
	Category.create(name:"category#{x}")
end
User.create(username:"aa",email:"aa@hp.com",password:"aaaaaaaa",admin:"true")