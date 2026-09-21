// Package board is a realm. It deliberately imports strs at BOTH versions,
// through table (which is still on v0) and directly (on v1). Two versions of
// one package coexisting is normal, and any version scheme has to survive it.
package board

import (
	"gno.land/p/demo/strs/v1"
	"gno.land/p/demo/table/v0"
)

var t table.Table

func Add(row string) { t.Add(row) }

func Render(path string) string {
	head, err := strs.Repeat("=", 20)
	if err != nil {
		return "error"
	}
	return head + "\n" + table.Rule(20)
}
