Pod::Spec.new do |s|
  s.name = 'J2ObjC-Framework'
  s.version = '2.0.3'
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

  s.subspec 'headers' do |h|
    h.dependency "#{s.name}/JRE-headers"
    h.dependency "#{s.name}/JSR305-headers"
  end

  s.subspec 'JRE-headers' do |jreh|
    jreh.preserve_paths = 'dist' # work around empty spec error

    xcconfig_entry = {
      "HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/J2ObjC-Framework/dist/frameworks/JRE.framework/Headers\""
    }
    jreh.xcconfig = xcconfig_entry
    jreh.pod_target_xcconfig = xcconfig_entry
  end

  s.subspec 'JRE' do |jre|
    jre.dependency "#{s.name}/JRE-headers"
    jre.ios.vendored_frameworks = "dist/frameworks/JRE.framework"
    jre.libraries = 'z', 'icucore'
  end

  s.subspec 'JSR305-headers' do |jsr305h|
    jsr305h.preserve_paths = 'dist' # work around empty spec error

    xcconfig_entry = {
      "HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/J2ObjC-Framework/dist/frameworks/JSR305.framework/Headers\""
    }
    jsr305h.xcconfig = xcconfig_entry
    jsr305h.pod_target_xcconfig = xcconfig_entry
  end

  s.subspec 'JSR305' do |jsr305|
    jsr305.dependency "#{s.name}/JRE"
    jsr305.dependency "#{s.name}/JSR305-headers"
    jsr305.ios.vendored_frameworks = "dist/frameworks/JSR305.framework"
  end

end
