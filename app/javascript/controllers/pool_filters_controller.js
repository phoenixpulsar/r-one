import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "mobilePanel"]
  
  connect() {
    console.log("PoolFilters controller connected")
    console.log("Overlay target:", this.hasOverlayTarget)
    console.log("Mobile panel target:", this.hasMobilePanelTarget)
  }
  
  toggleMobile(event) {
    event.preventDefault()
    this.overlayTarget.classList.toggle('hidden')
    this.mobilePanelTarget.classList.toggle('-translate-x-full')
  }
  
  closeMobile(event) {
    event.preventDefault()
    this.overlayTarget.classList.add('hidden')
    this.mobilePanelTarget.classList.add('-translate-x-full')
  }
}
