import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]

  toggle(event) {
    event.preventDefault()
    this.panelTarget.classList.toggle("hidden")

    const expanded = this.panelTarget.classList.contains("hidden") ? "false" : "true"
    this.element.querySelector("button").setAttribute("aria-expanded", expanded)
  }
}
