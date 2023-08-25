import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()

export default class extends Controller {
  static targets = ["picker", "start", "end"]

  connect() {
    flatpickr(this.pickerTarget, {
      mode: "range",
      onChange: function(selectedDates, dateStr, instance) {
        this.startTarget.value = selectedDates[0]
        this.endTarget.value = selectedDates[1]
      }.bind(this),
    })
  }
}
