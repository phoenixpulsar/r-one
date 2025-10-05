import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timeout = null
  }
  
  debouncedSubmit(event) {
    if (window.innerWidth < 1024) {
      return
    }
    
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 300)
  }
}
