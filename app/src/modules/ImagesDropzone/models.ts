export interface TouchData {
  key: string
  signed_id: string
  upload_url: string
  upload_headers: { [x: string]: string }
}

export interface CreateData {
  id: number
}

export interface ImageData {
  id: number
  key: string
  src: string
  weight: number
  active: boolean
}
