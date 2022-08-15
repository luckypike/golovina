import { makeAutoObservable } from 'mobx'
import * as Sentry from '@sentry/nextjs'
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
  categories: Array<{
    id: number
    title: string
    slug: string
    weight: number
  }>
  themes: Array<{ id: number; title: string; slug: string; weight: number }>
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
      editor: false,
    },
    cart: 0,
    wishlist: 0,
    categories: [],
    themes: [],
  }

  traceparentId: string
  headerInvert = false
  layoutStore = new LayoutStore()

  constructor(sessionData: SessionData, transactionId: string) {
    this.sessionData = sessionData
    this.traceparentId = transactionId

    makeAutoObservable(this)

    this.setSentryTraceparentId()
  }

  setHeaderInvert = (headerInvert: boolean) => {
    this.headerInvert = headerInvert
  }

  setSentryTraceparentId(): void {
    Sentry.configureScope((scope) => {
      scope.setTag('transaction_id', this.traceparentId)
    })
  }

  get isAuth(): boolean {
    return this.sessionData.user.id > 0 && this.sessionData.user.state > 0
  }

  get isEditor(): Boolean {
    return this.isAuth && this.sessionData.user.editor
  }
}
