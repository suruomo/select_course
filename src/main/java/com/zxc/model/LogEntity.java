package com.zxc.model;

public class LogEntity {
	    private int id; 
        private String userId;
        private String module;
        private String method;
        private String response_date;
        private String username;
        private String data;
        private String commit;
        
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getUserId() {
			return userId;
		}
		public void setUserId(String userId) {
			this.userId = userId;
		}
		public String getModule() {
			return module;
		}
		public void setModule(String module) {
			this.module = module;
		}
		public String getMethod() {
			return method;
		}
		public void setMethod(String method) {
			this.method = method;
		}
		public String getResponse_date() {
			return response_date;
		}
		public void setResponse_date(String response_date) {
			this.response_date = response_date;
		}
		
		public String getUsername() {
			return username;
		}
		public void setUsername(String username) {
			this.username = username;
		}
		public String getData() {
			return data;
		}
		public void setData(String data) {
			this.data = data;
		}
		public String getCommit() {
			return commit;
		}
		public void setCommit(String commit) {
			this.commit = commit;
		}
        
}
