default_platform(:ios)

platform :ios do

  # reference :
  # - https://github.com/SlatherOrg/slather
  # output : 
  # - automation/xcov/markdown_report/output_directory/xccovreport-0.xccovreport
  # - automation/xcov/markdown_report/output_directory/index.html
  # - automation/xcov/markdown_report/output_directory/report.json
  # - automation/xcov/markdown_report/output_directory/report.md
  # - automation/xcov/markdown_report/output_directory/resources 
  # - automation/xcov/markdown_report/output_directory/xccovarchive-0.xccovarchive
  # outputnya wajib di simpan di github untuk show and send code coverage
  # ini bisa running via local, hosted, dan github untuk show and send code coverage
  desc "bundle exec fastlane exec_code_coverage_xcov_by_all_runner"
  lane :exec_code_coverage_xcov_by_all_runner do |values|

    context_version_number = lane_context[SharedValues::VERSION_NUMBER]
    context_build_number = lane_context[SharedValues::BUILD_NUMBER]

    xcov(
      workspace: WORKSPACE_APP,
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      xccov_file_direct_path: values[:path],
      output_directory: "./automation/xcov/#{context_version_number}_#{context_build_number}/html_report/output_directory",
      html_report: true, 
      minimum_coverage_percentage: 1.0,
      # only_project_targets: true,
      # include_test_targets: true
    )

    xcov(
      workspace: WORKSPACE_APP,
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      xccov_file_direct_path: values[:path],
      output_directory: "./automation/xcov/#{context_version_number}_#{context_build_number}/markdown_report/output_directory",
      markdown_report: true,
      minimum_coverage_percentage: 1.0,
      # only_project_targets: true,
      # include_test_targets: true
    )

    xcov(
      workspace: WORKSPACE_APP,
      scheme: RELEASE_SCHEME,
      configuration: DEBUG_CONFIGURATION,
      xccov_file_direct_path: values[:path],
      output_directory: "./automation/xcov/#{context_version_number}_#{context_build_number}/json_report/output_directory",
      json_report: true,
      minimum_coverage_percentage: 1.0,
      # only_project_targets: true,
      # include_test_targets: true
    )
  end

end

# - [kurang tau fungsi nya apa, dan sepertinya kurang bisa di pakai sepertinya di ios] : danger-plugin-flow - Ensure all JS files that get touched in a PR are flow typed.
# - [kurang ok] : danger-plugin-labels - Let any contributor add labels to their PRs and issues.
# - [] : danger-plugin-yarn - Provides dependency information on dependency changes in a PR *
# - [] : danger-plugin-jest - Danger plugin for Jest.
# - [] : danger-plugin-spellcheck - Spell checks .md files in a PR using node-markdown-spellcheck.
# - [] : danger-plugin-jira-issue - Danger plugin to link JIRA issue in pull request.

# - [] : danger-plugin-tslint - Danger plugin for TSLint.

# - [] : danger-plugin-mentor - A Danger plugin to level up with each pull request.
# - [] : danger-plugin-eslint - Eslint your code with Danger.
# - [] : danger-plugin-textlint - Danger plugin for textlint.

# - [] : danger-plugin-slack - DangerJS plugin to send report & message to Slack.
# - [] : danger-plugin-typetalk - DangerJS plugin to send report & message to Typetalk.
# - [] : danger-plugin-no-test-shortcuts - Danger plugin to prevent merging test shortcuts (.only and .skip).
# - [] : danger-plugin-lint-report - A Danger Plugin to parse lint reports (checkstyle, Android lint) and post pull request comments.
# - [] : danger-plugin-pr-hygiene - A Danger plugin for enforcing good PR hygiene.


# sepertinya bisa :
# - [] : danger-plugin-istanbul-coverage - Danger.js plugin for monitoring code coverage on changed files.
# - dangerjs-plugin - Taqtile Danger-js Plugin.
# - [] : danger-plugin-xcode-report - Add your Xcode test results to Danger.
# https://github.com/ashfurrow/danger-ruby-swiftlint
# https://github.com/diogot/danger-xcode_summary

# https://github.com/danger/danger-mention
# https://github.com/giginet/danger-xcprofiler
# https://github.com/jonallured/danger-commit_lint
# https://github.com/BrunoMazzo/Danger-Slather
# https://github.com/valeriomazzeo/danger-xcodebuild
# https://github.com/garriguv/danger-ruby-swiftformat
# https://github.com/m-nakamura145/danger-review_requests
# https://github.com/manicmaniac/danger-periphery

# progress
# https://github.com/fastlane-community/danger-xcov

