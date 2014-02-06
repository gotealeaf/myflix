Fabricator(:relationship) do
  follower { Fabricate(:user) }
  leader { Fabricate(:user) }
end
