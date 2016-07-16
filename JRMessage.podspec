
Pod::Spec.new do |s|

  s.name         = "JRMessage"
  s.version      = "0.2.1"
  s.summary      = "A short description of JRMessage."

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/Jerrywx/JRMessage-Demo"

  s.license      = "MIT"
  s.author             = { "wangx" => "wangx@imooc.com" }

  s.source       = { :git => "https://github.com/Jerrywx/JRMessage-Demo.git", :tag => "0.2.1" }

  s.source_files   = "JRMessage-Demo/src/*.{h,m}"
  #s.source_files  = "Classes/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"

end
