default_platform(:ios)

platform :ios do
  desc "Nuke distribution certificates and profiles on developer portal and git storage"
  lane :nuke_distribution do
    load_app_store_connect_api_key
    api_key = lane_context[SharedValues::APP_STORE_CONNECT_API_KEY]
    match_nuke(
      type: "appstore",
      git_basic_authorization: Base64.strict_encode64(GIT_AUTHORIZATION),
      api_key: api_key
    )
  end
end
