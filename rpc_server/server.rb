
this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'anycable_services_pb'

# Anycable Socket
# => per connection store
# def streams
#   @streams ||= {start: [], stop: []}
# end


class AnycableRpcHandler < Anycable::RPC::Service
  def connect(connection_req, _call)
    # 1. 소켓 빌드
    # 2. connection factory (connection 클래스 initiailize.. current_user, identifier 이런거 정보 세팅)
    # 3. handle_open => current_user 파악하고 socket.submit (welcome / disconnect)
    # 4. connection_response (socket 상태에 따라 failure or success)
  end

  def command(command_msg, _call)
    # 1. 소켓 빌드
    # 2. connection 객체 생성 (socket, connection_identifier로 )
    #    ㄴ anycable_rails connection_factory
    # 3. handle_channel_command
    #    ㄴ anycable_rails handle_channel_command
    #    ㄴ command 타입 : subscribe, unsubscribe, message
    #    ㄴ conn -< subscriptions (스트림)) >- channel
    #    ㄴ pick channel & call method
    # command_reponse => 스트림 정보 내려줌.
  end

  def disconnect(disconnect_req, _call)
    # 1. 소켓 빌드
    # 2. connection 객체
    # 3. handle_close
    #    ㄴ conn.connections 모두 unsubscribe
    #    ㄴ conn.disconnect
  end
end

class AnycableRpcServer < Anycable::RPC::Service
  # say_hello implements the SayHello rpc method.
  def connect(connection_req, _unused_call)
    p '=== connect request ==='
    p connection_req
    p '---------------------'
    p _unused_call
    p '----------------------'
    status = Anycable::Status::SUCCESS
    response = Anycable::ConnectionResponse.new(status: status, identifiers: 'jimin', transmissions: ['a', 'b', 'c'])
  end

  # def say_hello_again(hello_req, _unused_call)
  #   Helloworld::HelloReply.new(message: "Hello again, #{hello_req.name}")
  # end
end

# main starts an RpcServer that receives requests to GreeterServer at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(AnycableRpcServer)
  # Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to 
  #   gracefully shutdown.
  # User could also choose to run server via call to run_till_terminated
  p "** server started **"
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main