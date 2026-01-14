package internal

import (
	"context"

	pb "github.com/neevbhandari13/bookr/backend/gen/booking"
)

type BookingServiceserver struct {
	pb.UnimplementedBookingServiceServer
}
