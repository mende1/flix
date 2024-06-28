import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.style.animation = 'fade-in-and-out 7s'
      this.element.remove();
    }, 7000)
  }

  close() {
    this.element.remove();
  }
}
