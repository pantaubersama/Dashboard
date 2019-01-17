class UserPantauAuth < PantauAuthApplicationRecord
  self.table_name = "users"
  has_one :verification, foreign_key: 'user_id'
  mount_uploader :avatar, AvatarUploader
end