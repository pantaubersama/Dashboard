class Api::Auth::UsersClusters < InitApiAuth
	def all(page=1, per_page=30, q="*", o="and", m="word_start", filter_by="")
    options = { 
			query: { page: page, per_page: per_page, q: q, o: o, m: m, filter_by: filter_by }
    }
    self.class.get("/v1/users_clusters", options)
	end
	
	def invite_user(emails, cluster_id)
		@options = { 
      query: {
				emails: emails, cluster_id: cluster_id
			},
      headers: {
				Authorization: "Bearer e10e623493e0ac78b36c0284bba2efe28a9f41d0741924ea85569795b23eb1ed"
			}
    }
		self.class.post("/v1/clusters/invite", @options)
	end
end
