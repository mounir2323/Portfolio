
package main

import (
	"encoding/json"
	"net/http"
)

// Item struct represents an item with ID and Name
type Item struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

// CORS middleware to allow cross-origin requests
func enableCORS(next http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}

		next(w, r)
	}
}

// getItems returns a JSON response with items
func getItems(w http.ResponseWriter, r *http.Request) {
	items := []Item{
		{ID: 1, Name: "Item One"},
		{ID: 2, Name: "Item Two"},
		{ID: 3, Name: "Item Three"},
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(items)
}

func main() {
	http.HandleFunc("/api/items", enableCORS(getItems))
	http.ListenAndServe(":8081", nil)
}
