Pod::Spec.new do |s|
  s.name = 'J2ObjC-Framework'
  s.version = '1.3.1'
  s.summary = 'Swift-compatible J2ObjC cocoapod'
  s.homepage = 'http://j2objc.org'

  s.author = 'J2ObjC Team'
  s.license = { :type => 'Apache-2.0', :file => 'LICENSE' }

  s.platform = :ios
  s.source = { :git => 'https://github.com/kustra/J2ObjC-Framework.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.preserve_paths = 'dist'
  s.prepare_command = <<-CMD
    scripts/download.sh
  CMD

  s.frameworks = 'Security'
  s.osx.frameworks = 'ExceptionHandling'
  s.pod_target_xcconfig = {
    'WARNING_CFLAGS' => '-Wno-nullability-completeness',
    'CLANG_WARN_DOCUMENTATION_COMMENTS' => 'YES'
  }

  s.default_subspec = 'all'

  s.subspec 'all' do |all|
    all.dependency "#{s.name}/JRE"
    all.dependency "#{s.name}/JSR305"
  end

  s.subspec 'JRE' do |jre|
    jre.ios.vendored_frameworks = "dist/frameworks/JRE.framework"
    jre.libraries = 'z', 'icucore'
    jre.xcconfig = {
      "HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/J2ObjC-Framework/dist/frameworks/JRE.framework/Headers\""
    }
  end

  s.subspec 'JSR305' do |jsr305|
    jsr305.ios.vendored_frameworks = "dist/frameworks/JSR305.framework"
    jsr305.xcconfig = {
      "HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/J2ObjC-Framework/dist/frameworks/JSR305.framework/Headers\""
    }
  end

end
