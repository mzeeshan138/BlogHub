import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "image", "placeholder"]

  update() {
    const file = this.inputTarget.files[0]
    if (!file) return

    this.imageTarget.src = URL.createObjectURL(file)
    this.imageTarget.classList.remove("d-none")
    this.placeholderTarget.classList.add("d-none")
  }
}
