import { makeAutoObservable } from 'mobx'
// import { IndexData, InstagramData, SlideData } from './models'

export class LayoutStore {
  activeNav = true

  constructor() {
    makeAutoObservable(this)
  }

  setActiveNav = (activeNav: boolean) => {
    this.activeNav = activeNav
  }
}
