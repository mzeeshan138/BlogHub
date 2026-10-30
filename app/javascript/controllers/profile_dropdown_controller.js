import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "menu"]

  toggle(event) {
    event.stopPropagation()
    this.isOpen ? this.close() : this.open()
  }

  closeIfOutside(event) {
    if (!this.element.contains(event.target)) this.close()
  }

  close() {
    this.menuTarget.classList.remove("show")
    this.buttonTarget.setAttribute("aria-expanded", "false")
  }

  open() {
    this.menuTarget.classList.add("show")
    this.buttonTarget.setAttribute("aria-expanded", "true")
  }

  get isOpen() {
    return this.buttonTarget.getAttribute("aria-expanded") === "true"
  }
}
