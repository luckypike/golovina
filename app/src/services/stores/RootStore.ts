import { makeAutoObservable } from 'mobx'
import { LayoutStore } from '../../layout/store'

export interface SessionData {
  user: {
    id: number
    state: number
    editor: boolean
    name: string
    sname: string
    email: string
    phone: string
  }
  wishlist: number
  cart: number
  categories: Array<{ id: number, title: string, slug: string, weight: number }>
  themes: Array<{ id: number, title: string, slug: string, weight: number }>
}

export class RootStore {
  sessionData: SessionData = {
    user: {
      id: 0,
      name: '',
      sname: '',
      email: '',
      phone: '',
      state: 0,
      editor: false
    },
    cart: 0,
    wishlist: 0,
    categories: [],
    themes: []
  }

  headerInvert = false
  layoutStore = new LayoutStore()

  constructor (sessionData: SessionData) {
    this.sessionData = sessionData

    makeAutoObservable(this)
  }

  setHeaderInvert = (headerInvert: boolean) => {
    this.headerInvert = headerInvert
  }

  get isAuth (): boolean {
    return this.sessionData.user.id > 0 && this.sessionData.user.state > 0
  }

  get isEditor (): Boolean {
    return this.isAuth && this.sessionData.user.editor
  }
}
