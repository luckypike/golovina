import { makeAutoObservable } from 'mobx'
import { CartData, OrderData, OrderItemData, Step } from './models'

export class CartStore {
  order?: OrderData = undefined
  orderItems: OrderItemData[] = []
  reload = true
  step: Step = 'cart'
  verify = false
  verified = false

  constructor() {
    makeAutoObservable(this)
  }

  setData = (data: CartData) => {
    this.order = data.order
    this.orderItems = data.order_items
    this.reload = false
  }

  setReload = (reload: boolean) => {
    this.reload = reload
  }

  setStep = (step: Step) => {
    this.step = step
  }

  setVerify = (verify: boolean) => {
    this.verify = verify
  }

  setVerified = (verified: boolean) => {
    this.verified = verified
  }
}
