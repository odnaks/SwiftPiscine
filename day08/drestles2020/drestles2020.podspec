Pod::Spec.new do |spec|

  spec.name         = "drestles2020"
  spec.version      = "0.0.1"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
	Super unuseful pod, but i did it myself
                   DESC

  spec.homepage     = "https://github.com/odnaks"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "drestles" => "drestles@student.21-school.ru" }

  spec.ios.deployment_target = "13.2"
  spec.swift_version = "5"

  spec.source_files  = "drestles2020/**/*.xcdatamodeld"

end