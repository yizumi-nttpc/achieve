#class Poem < ActiveRecord::Base
#class Poem < ActiveResource::Base
#  self.site = "https://stormy-eyrie-30619.herokuapp.com"
class Poem
  include Her::Model
end
