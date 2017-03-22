Rails.application.config.middleware.use OmniAuth::Builder do
     provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
     {
         :name => "google",
         :callback_path => '/auth/callback',
         approval_prompt: 'force',
         access_type:"offline",
         scope: 'userinfo.email,calendar'
     }
end
