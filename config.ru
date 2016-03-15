# 基于Rack的服务器，使用这个文件，来开始应用  This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__) #是否应该是../config/environments？
#require 'rack/raw_upload'

#use Rack::RawUpload
run AmazingPanel::Application
