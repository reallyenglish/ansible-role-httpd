require 'spec_helper'
require 'serverspec'

service = 'httpd'
config  = '/etc/httpd.conf'
user    = 'www'
group   = 'www'
ports   = [ 80 ]
log_dir = '/var/www/logs'

describe file(config) do
  it { should be_file }
  its(:content) { should_not match /^chroot\s+/ }
  its(:content) { should_not match /^default type\s+/ }
  its(:content) { should_not match /^logdir\s+/ }
  its(:content) { should match /interface = "egress"/ }
  its(:content) { should match /prefork 2/ }
  its(:content) { should match /types {\n\s+include "#{ Regexp.escape('/usr/share/misc/mime.types') }"/ }
  its(:content) { should match /server "default" {\n\s+listen on \* port 80\n}/ }
  its(:content) { should match /server "example.org" {\n\s+listen on \$interface port 80\n}/ }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'daemon' }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command('ftp -o -  http://localhost/bgplg/index.html') do
  its(:stdout) { should match Regexp.escape('<title>bgplg...</title>') }
end
