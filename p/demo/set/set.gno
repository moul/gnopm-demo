// Package set is added AFTER the migration, so it never had a v0 directory.
// The version is in gnomod.toml and nowhere else.
package set

type Set struct{ items []string }

func (s *Set) Add(v string) {
	for _, existing := range s.items {
		if existing == v {
			return
		}
	}
	s.items = append(s.items, v)
}

func (s *Set) Len() int { return len(s.items) }
