import axios from 'axios'
import { makeAutoObservable, runInAction } from 'mobx'
import { CreateData, ImageData } from './models'

export class ImagesDropzoneStore {
  images: Record<string, ImageDropzoneStore> = {}

  addImage = (id: number, key: string, src: string, active: boolean, weight: number, upload?: UploadData) => {
    this.images[key] = new ImageDropzoneStore(this, id, key, src, active, weight, upload)
  }

  addImages = (images: ImageData[]) => {
    images.forEach(image => {
      this.addImage(image.id, image.key, image.src, image.active, image.weight)
    })
  }

  constructor () {
    makeAutoObservable(this)
  }

  removeEmpty = () => {
    Object.entries(this.images)
      .filter(([k, image]) => image.active)
      .sort(([_a, a], [_b, b]) => {
        return a.weight - b.weight
      })
      .map(([key, image], i) => image.setWeight(i + 1))
  }

  get currentWeight (): number {
    return Math.max(
      ...Object.entries(this.images)
        .filter(([k, image]) => image.active)
        .map(([k, image]) => image.weight),
      0
    )
  }

  get toParams (): Array<{ id: number, key: string, weight: number, active: boolean, src: string }> {
    return Object.entries(this.images).map(([key, image]) => ({
      id: image.id,
      key: key,
      src: image.src,
      active: image.active,
      weight: image.weight
    }))
  }
}

export class ImageDropzoneStore {
  id = 0
  key: string
  src: string
  loading = false
  weight: number
  active: boolean
  imageDropzoneStore: ImagesDropzoneStore

  constructor (
    imageDropzoneStore: ImagesDropzoneStore,
    id: number,
    key: string,
    src: string,
    active: boolean,
    weight: number,
    upload?: UploadData
  ) {
    this.id = id
    this.key = key
    this.src = src
    this.active = active
    this.weight = weight

    makeAutoObservable(this, { imageDropzoneStore: false })
    this.imageDropzoneStore = imageDropzoneStore

    if (upload != null) {
      void this.upload(upload)
    }
  }

  upload = async (upload: UploadData) => {
    this.loading = true
    await axios.put(upload.url, upload.file, { headers: upload.headers })

    const { data: createData } = await axios.post<CreateData>('/images', {
      file: upload.signed_id,
      uuid: this.key
    })

    runInAction(() => {
      this.id = createData.id
      this.loading = false
    })
  }

  setWeight = (weight: number) => {
    this.weight = weight
  }

  toggleActive = () => {
    if (this.loading) return

    if (this.active) {
      this.active = !this.active
      this.imageDropzoneStore.removeEmpty()
      this.weight = 0
    } else {
      this.active = !this.active
      this.weight = this.imageDropzoneStore.currentWeight + 1
    }
  }
}

interface UploadData {
  file: File
  url: string
  signed_id: string
  headers: { [x: string]: string }
}
