import { Controller } from "@hotwired/stimulus"
import Cropper from 'cropperjs'

export default class extends Controller {

  static targets = ['modalTrigger', 'croppable', 'preview', 'croppedImageField', 'removeButton']


  connect() {
    console.log("image_preview_controller is connected")
  }

  changed(e) {
    const reader = new FileReader()
    reader.onload = () => {
      this.croppableTarget.src = reader.result
      this.initializeCropper(this.croppableTarget)
      this.openModal()
    }
    reader.readAsDataURL(e.target.files[0])
    // 選択した元の画像はサーバに送流必要がないので。disabledにするとファイルを選択し直せなくなるのでvalueを""にしている。
    e.target.value = ""
  }

  initializeCropper(image) {
    if (this.cropperObj) {
      this.cropperObj.destroy()
    }
    this.cropperObj = new Cropper(image, {
      aspectRatio: 16 / 9,
    })
  }

  crop(e) {
    e.preventDefault()

    const dataURL = this.cropperObj.getCroppedCanvas().toDataURL('image/jpeg')
    this.croppedImageFieldTarget.value = dataURL

    this.previewTarget.src = dataURL
    this.closeModal()

    this.removeButtonTarget.style.visibility = 'visible'
  }

  openModal() {
    this.modalTriggerTarget.checked = true
  }

  closeModal() {
    this.modalTriggerTarget.checked = false
  }
}
