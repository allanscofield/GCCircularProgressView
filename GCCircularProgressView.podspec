#
# Be sure to run `pod lib lint GCCircularProgressView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GCCircularProgressView'
  s.version          = '1.0.4'
  s.summary          = 'A circular progress view.'
  s.description      = <<-DESC
This library creates a circular progress view that may be used for loading or downloading UI. 
                       DESC

  s.homepage         = 'https://github.com/gigiodc/GCCircularProgressView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gigiodc' => 'giancarlo.cavalcante@tvglobo.com.br' }
  s.source           = { :git => 'https://github.com/gigiodc/GCCircularProgressView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = "Sources/**/*.{swift}"
  
  # s.resource_bundles = {
  #   'GCCircularProgressView' => ['GCCircularProgressView/Assets/*.png']
  # }

  s.swift_version = '4.0'
  
end
