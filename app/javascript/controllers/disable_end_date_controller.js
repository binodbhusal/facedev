import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="disable-end-date"
export default class extends Controller {
  connect() {
    this.disableEndDate()
    console.log("end date connected")
  }
  initialize(){
    this.element.setAttribute('data-action', "click -> disable-end-date#disableEndDate")
  }
  disableEndDate(event){
    event.preventDefault()
    const endDateElement = document.getElementById('work_experience_end_date')
    if(this.element.checked){
      endDateElement.setAttribute("disabled", true)
    }else{
      endDateElement.removeAttribute("disabled")
    }
  }
}
