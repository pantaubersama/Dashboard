class Cluster < PantauAuthApplicationRecord
    belongs_to :category
    belongs_to :requester, optional: true, class_name: "UserPantauAuth"
end
