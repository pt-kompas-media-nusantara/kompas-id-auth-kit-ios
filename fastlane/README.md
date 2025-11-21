fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios exec_build_ipa

```sh
[bundle exec] fastlane ios exec_build_ipa
```

bundle exec fastlane exec_build_ipa

### ios exec_multi_build_ipa

```sh
[bundle exec] fastlane ios exec_multi_build_ipa
```

bundle exec fastlane exec_multi_build_ipa

### ios exec_clear_cache_pods

```sh
[bundle exec] fastlane ios exec_clear_cache_pods
```

fastlane exec_clear_cache_pods

### ios exec_create_tag_release

```sh
[bundle exec] fastlane ios exec_create_tag_release
```

bundle exec fastlane exec_create_tag_release

### ios load_app_store_connect_api_key

```sh
[bundle exec] fastlane ios load_app_store_connect_api_key
```

App Store Connect Api Key

### ios lane_get_app_store_connect_api_key

```sh
[bundle exec] fastlane ios lane_get_app_store_connect_api_key
```

bundle exec fastlane lane_get_app_store_connect_api_key

### ios remove_credentials

```sh
[bundle exec] fastlane ios remove_credentials
```

fastlane remove_credentials

### ios setup_credentials

```sh
[bundle exec] fastlane ios setup_credentials
```

Setup Credentials

### ios lane_get_keychain

```sh
[bundle exec] fastlane ios lane_get_keychain
```

bundle exec fastlane lane_get_keychain

### ios upload_by_pilot

```sh
[bundle exec] fastlane ios upload_by_pilot
```

Upload IPA by Pilot

### ios upload_by_deliver

```sh
[bundle exec] fastlane ios upload_by_deliver
```

Upload IPA by Deliver

### ios load_gym_configuration

```sh
[bundle exec] fastlane ios load_gym_configuration
```

Gym Configuration for Github

### ios lane_get_gym

```sh
[bundle exec] fastlane ios lane_get_gym
```

bundle exec fastlane lane_get_gym

### ios lane_get_version_number_from_xcode

```sh
[bundle exec] fastlane ios lane_get_version_number_from_xcode
```

lane_get_version_number_from_xcode

### ios lane_get_version_manually_from_xcconfig

```sh
[bundle exec] fastlane ios lane_get_version_manually_from_xcconfig
```

bundle exec fastlane lane_get_version_number

### ios lane_get_version_number

```sh
[bundle exec] fastlane ios lane_get_version_number
```

bundle exec fastlane lane_get_version_number

### ios lane_latest_testflight_build_number

```sh
[bundle exec] fastlane ios lane_latest_testflight_build_number
```

lane_latest_testflight_build_number

### ios lane_get_latest_testflight_build_number

```sh
[bundle exec] fastlane ios lane_get_latest_testflight_build_number
```

bundle exec fastlane lane_get_latest_testflight_build_number

### ios lane_increment_build_number

```sh
[bundle exec] fastlane ios lane_increment_build_number
```

lane_increment_build_number

### ios lane_get_increment_build_number

```sh
[bundle exec] fastlane ios lane_get_increment_build_number
```

bundle exec fastlane lane_get_increment_build_number

### ios lane_multi_increment_build_number

```sh
[bundle exec] fastlane ios lane_multi_increment_build_number
```

Increment build number per group based on selected config groups

### ios lane_get_multi_increment_build_number

```sh
[bundle exec] fastlane ios lane_get_multi_increment_build_number
```

Get build number per group

### ios increment_build_number_from_latest_testflight_auto

```sh
[bundle exec] fastlane ios increment_build_number_from_latest_testflight_auto
```

Get Latest Build Number From Testflight and Increament It

### ios multi_increment_build_number_from_latest_testflight_auto

```sh
[bundle exec] fastlane ios multi_increment_build_number_from_latest_testflight_auto
```

Get Latest Build Number From Testflight and Increament It

### ios lane_get_build_number

```sh
[bundle exec] fastlane ios lane_get_build_number
```

lane_get_build_number

### ios lane_setup_app_version

```sh
[bundle exec] fastlane ios lane_setup_app_version
```

lane_setup_app_version

### ios increment_build_number_from_latest_testflight_manual

```sh
[bundle exec] fastlane ios increment_build_number_from_latest_testflight_manual
```

Setup Manual Build Number

### ios setup_match_app_identifier

```sh
[bundle exec] fastlane ios setup_match_app_identifier
```

Setup App Automatic

### ios lane_get_match

```sh
[bundle exec] fastlane ios lane_get_match
```

bundle exec fastlane lane_get_match

### ios setup_multi_match_app_identifier

```sh
[bundle exec] fastlane ios setup_multi_match_app_identifier
```

Setup match certs for all selected app identifiers

### ios lane_get_multi_match

```sh
[bundle exec] fastlane ios lane_get_multi_match
```

Get provisioning profile info per group

### ios lane_add_notes

```sh
[bundle exec] fastlane ios lane_add_notes
```

lane_add_notes

### ios lane_get_notes

```sh
[bundle exec] fastlane ios lane_get_notes
```

lane_get_notes

### ios lane_select_deployment_type

```sh
[bundle exec] fastlane ios lane_select_deployment_type
```

bundle exec fastlane lane_select_deployment_type

### ios lane_get_selected_deployment_type

```sh
[bundle exec] fastlane ios lane_get_selected_deployment_type
```

bundle exec fastlane lane_get_selected_deployment_type

### ios lane_get_app_identifiers_by_config_selection

```sh
[bundle exec] fastlane ios lane_get_app_identifiers_by_config_selection
```

bundle exec fastlane lane_get_app_identifiers_by_config_selection

### ios lane_get_multi_app_identifiers_by_config_selection

```sh
[bundle exec] fastlane ios lane_get_multi_app_identifiers_by_config_selection
```

bundle exec fastlane lane_get_multi_app_identifiers_by_config_selection

### ios send_to_github_coverage

```sh
[bundle exec] fastlane ios send_to_github_coverage
```

send_to_github_coverage

### ios send_to_github_ipa_path_output

```sh
[bundle exec] fastlane ios send_to_github_ipa_path_output
```

send_to_github_ipa_path_output

### ios send_to_github_app_path_output

```sh
[bundle exec] fastlane ios send_to_github_app_path_output
```

send_to_github_app_path_output

### ios lane_show_github_values

```sh
[bundle exec] fastlane ios lane_show_github_values
```

bundle exec fastlane exec_multi_build_ipa

### ios send_to_logger_get_app_identifiers_by_config_selection

```sh
[bundle exec] fastlane ios send_to_logger_get_app_identifiers_by_config_selection
```

send_to_logger_get_app_identifiers_by_config_selection

### ios send_to_logger_get_selected_deployment_type

```sh
[bundle exec] fastlane ios send_to_logger_get_selected_deployment_type
```

send_to_logger_get_selected_deployment_type

### ios send_to_logger_get_notes

```sh
[bundle exec] fastlane ios send_to_logger_get_notes
```

send_to_logger_get_notes

### ios send_to_logger_get_keychain

```sh
[bundle exec] fastlane ios send_to_logger_get_keychain
```

send_to_logger_get_keychain

### ios send_to_logger_get_app_store_connect_api_key

```sh
[bundle exec] fastlane ios send_to_logger_get_app_store_connect_api_key
```

send_to_logger_get_app_store_connect_api_key

### ios send_to_logger_lane_get_match

```sh
[bundle exec] fastlane ios send_to_logger_lane_get_match
```

send_to_logger_lane_get_match

### ios send_to_logger_lane_get_latest_testflight_build_number

```sh
[bundle exec] fastlane ios send_to_logger_lane_get_latest_testflight_build_number
```

send_to_logger_lane_get_latest_testflight_build_number

### ios send_to_logger_lane_get_version_number

```sh
[bundle exec] fastlane ios send_to_logger_lane_get_version_number
```

send_to_logger_lane_get_version_number

### ios send_to_logger_lane_get_increment_build_number

```sh
[bundle exec] fastlane ios send_to_logger_lane_get_increment_build_number
```

send_to_logger_lane_get_increment_build_number

### ios send_to_logger_lane_get_gym

```sh
[bundle exec] fastlane ios send_to_logger_lane_get_gym
```

send_to_logger_lane_get_gym

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
