class PantauAuthApplicationRecord < ApplicationRecord
  self.abstract_class = true
  establish_connection PANTAU_AUTH_DB
end
