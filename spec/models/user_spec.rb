require 'spec_helper'

describe User do
   it {has_many(:queue_items)}
end
