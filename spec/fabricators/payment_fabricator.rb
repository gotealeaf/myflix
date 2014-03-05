Fabricator(:payment) do
  amount { 999 }
  reference { "abcde" }
  user { Fabricate(:user) }
end