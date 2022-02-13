export interface IndexData {
  slides: SlideData[],
  instagram: InstagramData[]
}

export interface SlideData {
  id: number
  desc: string
  name: string
  link_relative: string
  image: string
}

export interface InstagramData {
  id: number
  permalink: string
  media_url: string
  media_type: string
}
