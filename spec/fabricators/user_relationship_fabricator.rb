Fabricator(:user_relationship)  do
  followee { Fabricate(:user) }
  follower { Fabricate(:user) }
end