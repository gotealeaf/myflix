Fabricator(:relationship) do
  user { Fabricate(:user) }
  leader { Fabricate(:user) }
end
