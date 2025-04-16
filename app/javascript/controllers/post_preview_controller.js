import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["titleInput", "bodyInput","publishedAtInput", "titlePreview", "bodyPreview","publishedAtPreview"]

    updateTitle() {
    this.titlePreviewTarget.textContent = this.titleInputTarget.value
    }

    updateBody() {
    this.bodyPreviewTarget.textContent = this.bodyInputTarget.value
    }

    updatePublishedAt() {
    this.publishedAtPreviewTarget.textContent = this.publishedAtInputTarget.value
    }
}
