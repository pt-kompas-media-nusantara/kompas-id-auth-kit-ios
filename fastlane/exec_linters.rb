default_platform(:ios)

platform :ios do

    # reference :
    # - https://docs.fastlane.tools/actions/swiftlint/
    # - https://github.com/realm/SwiftLint
    # output : 
    # - swiftlint.result.json
    # Note :
    # - the reporter value will be inside the json file (we can change format file)
    # chose output by reporter: # xcode , json, csv, checkstyle, codeclimate, junit, html, emoji, sonarqube, markdown, github-actions-logging
    desc "bundle exec fastlane exec_swiftlint_by_all_runner"
    lane :exec_swiftlint_by_all_runner do
        swiftlint(
            mode: :lint, # SwiftLint mode: :lint, :fix, :autocorrect or :analyze    
            executable: "Pods/SwiftLint/swiftlint",
            output_file: "swiftlint.result.json",
            config_file: ".swiftlint.yml",
            raise_if_swiftlint_error: true,
            reporter: "json", # xcode (this is default), json, csv, checkstyle, codeclimate, junit, html, emoji, sonarqube, markdown, github-actions-logging
            ignore_exit_status: true,               # Allow fastlane to continue even if SwiftLint returns a non-zero exit status (Default: false)
            quiet: true,                            # Don't print status logs like 'Linting ' & 'Done linting' (Default: false)
            strict: true 
        )
    end

end

