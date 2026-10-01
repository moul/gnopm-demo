// Package tinyavl stands in for a real external dependency.
package tinyavl

type Tree struct {
	keys []string
}

func (t *Tree) Set(k string) { t.keys = append(t.keys, k) }
func (t *Tree) Size() int    { return len(t.keys) }
