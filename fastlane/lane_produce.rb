default_platform(:ios)

platform :ios do
    # referrence :
    # https://docs.fastlane.tools/actions/produce/
    # ini di pakai untuk pertama kali buat fastlane
    # SharedValues::PRODUCE_APPLE_ID	The Apple ID of the newly created app. You probably need it for deliver
    desc "Create new iOS apps on App Store Connect and Apple Developer Portal using your command line"
    lane :setup_produce do

        # Default
        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER,
            app_name: DEVELOPER_APP_IDENTIFIER,
            skip_itc: true
        )

        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER_NOTIFICATION,
            app_name: DEVELOPER_APP_IDENTIFIER_NOTIFICATION,
            skip_itc: true
        )

        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER_PUSH_TEMPLATE,
            app_name: DEVELOPER_APP_IDENTIFIER_PUSH_TEMPLATE,
            skip_itc: true
        )

        # KID
        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER_KID,
            app_name: DEVELOPER_APP_IDENTIFIER_KID,
            skip_itc: true
        )

        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER_NOTIFICATION_KID,
            app_name: DEVELOPER_APP_IDENTIFIER_NOTIFICATION_KID,
            skip_itc: true
        )

        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER_PUSH_TEMPLATE_KID,
            app_name: DEVELOPER_APP_IDENTIFIER_PUSH_TEMPLATE_KID,
            skip_itc: true
        )
        
        # QA
        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER_QA_KID,
            app_name: DEVELOPER_APP_IDENTIFIER_QA_KID,
            skip_itc: true
        )

        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER_NOTIFICATION_QA_KID,
            app_name: DEVELOPER_APP_IDENTIFIER_NOTIFICATION_QA_KID,
            skip_itc: true
        )

        produce(
            app_identifier: DEVELOPER_APP_IDENTIFIER_PUSH_TEMPLATE_QA_KID,
            app_name: DEVELOPER_APP_IDENTIFIER_PUSH_TEMPLATE_QA_KID,
            skip_itc: true
        )

        puts "puts produce PRODUCE_APPLE_ID : #{lane_context[SharedValues::PRODUCE_APPLE_ID]}"
    end

end