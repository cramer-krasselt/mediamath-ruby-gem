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

    def get_access_cookie(options={})
      options[:grant_type] ||= "client_credentials"
      options[:redirect_uri] ||= self.redirect_uri
      params = access_cookie_params.merge(options)
      post("/api/v2.0/login",
           params,
           signature=false,
           raw=false,
           no_response_wrapper=true)
    end

    def access_code_from_response(res)
      if res.headers['location']
        return res.headers['location']
          .match(/code=([\w\d]+)/)
          .captures[0]
      end
    end

    def get_access_code(options={})
      params = access_code_params.merge(options)
      post("/oauth2/v1.0/authorize",
           params,
           signature=false,
           raw=true,
           no_response_wrapper=true)
    end

    def get_access_token(options={})
      params = access_token_params.merge(options)
      post("/oauth2/v1.0/token",
           params,
           signature=false,
           raw=true,
           no_response_wrapper=true)
    end

    private

    def authorization_params
      {
        :user => user
      }
    end

    def access_token_params
      {
        code: code,
        client_secret: api_secret,
        client_id: api_key,
        redirect_uri: redirect_uri,
        grant_type: 'authorization_code'
      }
    end

    def access_code_params
      {
        login: user,
        password: password,
        client_id: api_key,
        redirect_uri: redirect_uri,
        response_type: 'code'
      }
    end

    def access_cookie_params
      {
        user: user,
        password: password,
        api_key: api_key
      }
    end
  end
end
