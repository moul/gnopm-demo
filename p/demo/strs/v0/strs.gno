// Package strs is a leaf: it imports nothing.
package strs

// Repeat returns s written n times.
func Repeat(s string, n int) string {
	out := ""
	for i := 0; i < n; i++ {
		out += s
	}
	return out
}
