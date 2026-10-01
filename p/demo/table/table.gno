// Package table renders rows, and depends on two things: a package this repo
// owns (strs) and a vendored external one (tinyavl).
package table

import (
	"gno.land/p/demo/strs/v0"
	"gno.land/p/nt/tinyavl/v0"
)

type Table struct {
	index tinyavl.Tree
	rows  []string
}

func (t *Table) Add(row string) {
	t.index.Set(row)
	t.rows = append(t.rows, row)
}

// Rule returns a horizontal rule of the given width.
func Rule(width int) string { return strs.Repeat("-", width) }

func (t *Table) Len() int { return t.index.Size() }
