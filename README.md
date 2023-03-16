anycable 따라 만들기

GOLANG

golang 프로젝트 시작하기
go mod init ws_server
go mod tidy  => 빨간라인 있으면 알아서 설치

protoc 컴파일러 다운로드
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28


RUBY

cd rpc_server
grpc_tools_ruby_protoc -I ../proto --ruby_out=lib --grpc_out=lib anycable.proto