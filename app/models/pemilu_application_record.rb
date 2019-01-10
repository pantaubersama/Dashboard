class PemiluApplicationRecord < ApplicationRecord
  self.abstract_class = true
  establish_connection PEMILU_DB
end
