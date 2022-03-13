import { makeAutoObservable } from 'mobx'
// import { IndexData, InstagramData, SlideData } from './models'

export class LayoutStore {
  activeNav = false

  constructor () {
    makeAutoObservable(this)
  }

  setActiveNav = (activeNav: boolean) => {
    this.activeNav = activeNav
  }
}
