import axios from 'axios'
import { makeAutoObservable, runInAction } from 'mobx'

export interface SessionData {
  wishlist: number
  cart: number
}

export class RootStore {
  sessionData: SessionData = {
    cart: 0,
    wishlist: 0,
  }

  constructor(sessionData: SessionData) {
    this.sessionData = sessionData

    makeAutoObservable(this)
  }
}
