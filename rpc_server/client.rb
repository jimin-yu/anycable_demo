this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'anycable_services_pb'

def main
  # user = ARGV.size > 0 ?  ARGV[0] : 'world'
  # hostname = ARGV.size > 1 ?  ARGV[1] : 'localhost:50051'
  hostname = 'localhost:50051'
  stub = Anycable::RPC::Stub.new(hostname, :this_channel_is_insecure)
  begin
    env = Anycable::Env.new(url: 'abc', headers: {Authorization: 'application/json'})
    response = stub.connect(Anycable::ConnectionRequest.new(env: env))
    p response.identifiers
  rescue GRPC::BadStatus => e
    abort "ERROR: #{e.message}"
  end
end

main

# p Anycable::Status::SUCCESS.class

# env = Anycable::Env.new(url: 'abc', headers: {Authorization: 'application/json'})
# request = Anycable::ConnectionRequest.new(env: env)
# p request.env.url

# status = Anycable::Status::SUCCESS
# response = Anycable::ConnectionResponse.new(status: status, identifiers: 'jimin', transmissions: ['a', 'b', 'c'])
# p response.status