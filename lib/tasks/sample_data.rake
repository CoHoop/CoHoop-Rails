namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships

    make_microhoops

    make_tags
    make_tags_relationships
  end
end

def make_users
  User.create!(
    first_name: 'Gabriel',
    last_name:  'Dehan',
    email:      'dehan.gabriel@gmail.com',
    password:   'foobar',
    password_confirmation: 'foobar'
    )

  50.times do |n|
    first_name  = Faker::Name.first_name
    last_name  = Faker::Name.last_name
    p last_name
    email = "foo-#{ n+1}@bar.com"
    password  = "foobar"
    User.create!(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      password:   password,
      password_confirmation: password)
  end
end


def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..49]
  followers      = users[3..39]
  followed_users.each {  |followed| user.follow!(followed) }
  followers.each      {  |follower| follower.follow!(user) }
end

def make_microhoops
  users = User.all(limit: 10)
  15.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microhoops.create!(content: content) }
  end
  2.times do
    content = Faker::Lorem.sentence(5)
    users.each{ |user| user.microhoops.create!(content: content, urgent: true)}
  end
end

def make_tags
  words = Faker::Job::JOB_ADJ.dup
  35.times do
    name  = words.shift
    Tag.create!(name: name)
  end
end

def make_tags_relationships
  users = User.all
  tags = Tag.all
  5.times do
    tag = tags[rand(tags.length)]
    users.each { |u| u.tag!(tag.name, main: true) }
  end

  10.times do
    tag = tags[rand(tags.length)]
    users.each { |u| u.tag!(tag.name) }
  end
end
