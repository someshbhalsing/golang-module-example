package helper

import (
	"errors"
	"fmt"
)

// Welcome function will take the name as a parameter and will return with the welcome message
func Welcome(name string) (string, error) {
	if name != "" {
		return fmt.Sprintf("Welcome %s", name), nil
	}
	return "", errors.New("name cannot be empty")
}
