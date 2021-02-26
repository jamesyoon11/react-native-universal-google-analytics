require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = package["description"]
  s.homepage     = "https://github.com/jamesyoon11/react-native-universal-google-analytics"
  s.license      = package['license']
  s.authors      = package['author']
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/jamesyoon11/react-native-universal-google-analytics.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,c,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency 'GoogleAnalytics', '3.17.0'

end

