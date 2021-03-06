#!/usr/bin/env ruby
require "xmlrpc/client"
@SATELLITE_URL = "http://mysat5host.some.domain/rpc/api"
@SATELLITE_LOGIN = "sat5user"
@SATELLITE_PASSWORD = "changeme"

@client = XMLRPC::Client.new2(@SATELLITE_URL)
@key = @client.call('auth.login', @SATELLITE_LOGIN, @SATELLITE_PASSWORD)
#channels = @client.call('channel.listAllChannels', @key)
#channel = "tec-x86_64-server-software-test-7"
channel = ARGV[0]
puts channel
package_list1 = @client.call('channel.software.listAllPackages', @key, channel, "2017-01-20 08:00:00")
package_list2 = @client.call('channel.software.listAllPackages', @key, channel, "2001-01-20 08:00:00", "2017-01-20 08:00:00")
package_list = package_list1 + package_list2
for package in package_list do
  #puts package["name"]
  url = @client.call('packages.getPackageUrl', @key, package["id"])
  puts url
end
@client.call("auth.logout", @key)

