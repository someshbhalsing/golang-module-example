package helper

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func testWelcomePositive(t *testing.T) {
	_, err := Welcome("some name")
	assert.Nil(t, err, "Error should be nil")
}

func testWelcomeNegative(t *testing.T) {
	_, err := Welcome("")
	assert.NotNil(t, err, "should return an error")
}

func TestWelcome(t *testing.T) {
	testWelcomePositive(t)
	testWelcomeNegative(t)
}
