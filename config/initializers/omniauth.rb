Rails.application.config.middleware.use OmniAuth::Builder do
     provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
     {
         :name => "google",
         :callback_path => '/auth/callback',
         access_type:"offline",
         approval_prompt: 'force',
         scope: 'userinfo.email,calendar'
     }
end
