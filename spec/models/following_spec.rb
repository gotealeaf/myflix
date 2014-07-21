require "spec_helper"

describe Following do
 it { should belong_to(:user) } 
 it { should belong_to(:followed_users) }  
end