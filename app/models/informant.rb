class Informant < PantauAuthApplicationRecord
  belongs_to :user_pantau_auth, touch: true
end
