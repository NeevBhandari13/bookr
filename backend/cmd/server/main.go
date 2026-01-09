package main

import (
	"log"
	"net"

	"google.golang.org/grpc"
)

func main() {
	// binds a socket to port 50051
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("failed to listen on port 50051: %v", err)
	}

	server := grpc.NewServer()

	log.Println("gRPC server listening on :50051")
	err = server.Serve(lis)
	if err != nil {
		log.Fatalf("failed to serve: %v", err)
	}

}
