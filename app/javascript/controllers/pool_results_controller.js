import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "map", "mapToggleText"]
  
  toggleMap(event) {
    event.preventDefault()
    this.listTarget.classList.toggle('hidden')
    this.mapTarget.classList.toggle('hidden')
    
    if (this.mapTarget.classList.contains('hidden')) {
      this.mapToggleTextTarget.textContent = 'Map View'
    } else {
      this.mapToggleTextTarget.textContent = 'List View'
    }
  }
}
