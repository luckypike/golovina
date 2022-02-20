import { makeAutoObservable } from 'mobx'
import { CartData, OrderData, OrderItemData, Step } from './models'

export class CartStore {
  order?: OrderData = undefined
  order_items: OrderItemData[] = []
  reload = true
  step: Step = 'login'

  constructor() {
    makeAutoObservable(this)
  }

  setData = (data: CartData) => {
    this.order = data.order
    this.order_items = data.order_items
    this.reload = false
  }

  setReload = (reload: boolean) => {
    this.reload = reload
  }

  setStep = (step: Step) => {
    this.step = step
  }
}
