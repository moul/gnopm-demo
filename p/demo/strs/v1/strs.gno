// Package strs is a leaf: it imports nothing.
package strs

// Repeat returns s written n times.
//
// v1 CHANGED THE SIGNATURE: it now returns an error for a negative count,
// which is exactly the kind of compatibility break a reviewer needs to see.
func Repeat(s string, n int) (string, error) {
	if n < 0 {
		return "", errNegative
	}
	out := ""
	for i := 0; i < n; i++ {
		out += s
	}
	return out, nil
}

var errNegative = errorString("strs: negative count")

type errorString string

func (e errorString) Error() string { return string(e) }
