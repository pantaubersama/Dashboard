class Api::Auth::UsersClusters < InitApiAuth
	def all(page=1, per_page=30, q="*", o="and", m="word_start", filter_by="", cluster_id)
    options = { 
      query: { 
        page: page, per_page: per_page, q: q, o: o, m: m, filter_by: filter_by, cluster_id: cluster_id 
      },
      headers: {
        Authorization: "Bearer #{RequestStore.store[:my_api_token]}"
      }
    }
    self.class.get("/dashboard/v1/users_clusters", options)
	end
	
	def invite_user(emails, cluster_id)
		@options = { 
      query: {
				emails: emails, cluster_id: cluster_id
			},
      headers: {
				Authorization: "Bearer #{RequestStore.store[:my_api_token]}"
			}
    }
		self.class.post("/v1/clusters/invite", @options)
	end

	def remove_member(id, user_id)
		@options = {
      query: {
        id: id, user_id: user_id
      },
      headers: {
        Authorization: "Bearer #{RequestStore.store[:my_api_token]}"
      }
    }
    self.class.delete("/dashboard/v1/clusters/remove_members/#{id}", @options)
	end

end
