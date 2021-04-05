require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['summary']
  s.description  = package['description']
  s.homepage     = 'https://github.com/jamesyoon11/react-native-universal-google-analytics'
  s.license      = package['license']
  s.authors      = package['author']
  s.source       = { :git => 'https://github.com/jamesyoon11/react-native-universal-google-analytics.git', :tag => s.version }

  s.platform     = :ios, '8.0'
  s.source_files = 'ios/**/*.{h,m}'
  s.requires_arc = true

  s.dependency "React", "> 0.10.0"
  s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SRCROOT)/../sample/node_modules/react-native/React', "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES" }
end