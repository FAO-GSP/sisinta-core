# Each horizontal layer of a Profile, with analytical data
class Layer < ApplicationRecord
  belongs_to :profile, touch: true
end
