import { makeAutoObservable } from 'mobx'
import { IndexData, InstagramData, SlideData } from './models'

export class IndexStore {
  slides: SlideData[]
  instagram: InstagramData[]

  constructor (data: IndexData) {
    this.slides = data.slides
    this.instagram = data.instagram

    makeAutoObservable(this)
  }
}
