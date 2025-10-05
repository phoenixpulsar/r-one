import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "mobilePanel"]
  
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
