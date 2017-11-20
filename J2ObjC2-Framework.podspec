Pod::Spec.new do |s|
  s.name = 'J2ObjC2-Framework'
  s.version = '2.0.5-4'
  s.summary = 'Swift-compatible J2ObjC static framework pod'
  s.homepage = 'http://j2objc.org'

  s.author = 'J2ObjC Team'
  s.license = { :type => 'Apache-2.0', :file => 'LICENSE' }

  s.platform = :ios
  s.source = { :git => 'https://github.com/kustra/J2ObjC-Framework.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.static_framework = true

  s.preserve_paths = 'dist'
  s.prepare_command = <<-CMD
    scripts/download.sh
  CMD

  s.frameworks = 'Security'
  s.osx.frameworks = 'ExceptionHandling'

  s.default_subspec = 'all'

  s.subspec 'all' do |all|
    all.dependency "#{s.name}/JRE"
    all.dependency "#{s.name}/JSR305"
  end

  s.subspec 'JRE' do |jre|
    jre.vendored_frameworks = "dist/frameworks/JRE.framework"
    jre.ios.framework = 'UIKit'
    jre.libraries = 'z', 'icucore', 'iconv'
    jre.xcconfig = {
      "HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/#{s.name}/dist/frameworks/JRE.framework/Headers\""
    }
  end

  s.subspec 'JSR305' do |jsr305|
    jsr305.dependency "#{s.name}/JRE"
    jsr305.vendored_frameworks = "dist/frameworks/JSR305.framework"
    jsr305.xcconfig = {
      "HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/#{s.name}/dist/frameworks/JSR305.framework/Headers\""
    }
  end

end
