module MediaMathAPI
  # Defines HTTP request methods
  module OAuth
    # Return URL for OAuth authorization
    def authorize_url(options={})
      options[:response_type] ||= "code"
      options[:scope] ||= scope if !scope.nil? && !scope.empty?
      options[:redirect_uri] ||= self.redirect_uri
      params = authorization_params.merge(options)
      connection.build_url("/oauth/authorize/", params).to_s
    end

    # Return an access token from authorization
    def get_access_token(options={})
      options[:grant_type] ||= "client_credentials"
      options[:redirect_uri] ||= self.redirect_uri
      params = access_token_params.merge(options)
      post("/api/v2.0/login", params, signature=false, raw=false, no_response_wrapper=true)
    end

    private

    def authorization_params
      {
        :user => user
      }
    end

    def access_token_params
      {
        user: user,
        password: password,
        api_key: api_key
      }
    end
  end
end
