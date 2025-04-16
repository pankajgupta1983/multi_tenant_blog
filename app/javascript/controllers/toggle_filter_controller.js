import { Controller } from "@hotwired/stimulus"

// Connects to data-controller=“post-preview”
export default class extends Controller {    
    submit(event) {
        this.element.requestSubmit()
    }
}