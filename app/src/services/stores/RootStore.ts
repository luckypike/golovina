import { makeAutoObservable, runInAction } from 'mobx'
import { LayoutStore } from '../../layout/store'

export interface SessionData {
  wishlist: number
  cart: number
  categories: { id: number, title: string, slug: string, weight: number }[]
  themes: { id: number, title: string, slug: string, weight: number }[]
}

export class RootStore {
  sessionData: SessionData = {
    cart: 0,
    wishlist: 0,
    categories: [],
    themes: []
  }
  headerInvert = false
  layoutStore = new LayoutStore()

  constructor(sessionData: SessionData) {
    this.sessionData = sessionData

    makeAutoObservable(this)
  }

  setHeaderInvert = (headerInvert: boolean) => {
    this.headerInvert = headerInvert
  }
}
