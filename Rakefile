require 'cfpropertylist'

desc "Deploy IPA to HockeyApp"
task :deploy, [:config] do |task, args|
	Rake::Task["package"].invoke args[:config]

	hockey_token = "68e4619472924d868cc7cb2692955a79"
	hockey_identifier = get_hockey_app_id config: args[:config]

	sh "curl --fail \
        -F 'notify=0' \
        -F 'ipa=@build/XING.ipa' \
        -H 'X-HockeyAppToken: #{hockey_token}' \
        https://rink.hockeyapp.net/api/2/apps/#{hockey_identifier}/app_versions"
end

desc "Package IPA"
task :package, [:config] do |task, args|
	set_hockey_app_id config: args[:config]
	system "xcodebuild -workspace XING.xcworkspace -scheme XING -archivePath build/XING.xcarchive clean archive"
  system "./xcrun-safe.sh xcodebuild -exportArchive -exportOptionsPlist export-options.plist -archivePath build/XING.xcarchive -exportPath build/"
end

def get_hockey_app_id(config: 'Alpha')
	if config.eql? 'Alpha'
		return '8db0dd61661e4a17a20a44092c81f68d'
	else
		return 'd16792bd15134ee2b01d6b015d3f93cc'
	end
end

def set_hockey_app_id(config: 'Alpha')
	path = "XING/configuration.plist"
	plist = CFPropertyList::List.new(:file => path)
	data = CFPropertyList.native_types(plist.value)
	data['HOCKEY_APP_ID'] = get_hockey_app_id config: config
	plist = CFPropertyList::List.new
	plist.value = CFPropertyList.guess(data)
	plist.save(path, CFPropertyList::List::FORMAT_XML)
end