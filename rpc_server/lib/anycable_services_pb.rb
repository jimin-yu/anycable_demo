# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: anycable.proto for package 'anycable'

require 'grpc'
require 'anycable_pb'

module Anycable
  module RPC
    class Service

      include ::GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'anycable.RPC'

      rpc :Connect, ::Anycable::ConnectionRequest, ::Anycable::ConnectionResponse
      rpc :Command, ::Anycable::CommandMessage, ::Anycable::CommandResponse
      rpc :Disconnect, ::Anycable::DisconnectRequest, ::Anycable::DisconnectResponse
    end

    Stub = Service.rpc_stub_class
  end
end