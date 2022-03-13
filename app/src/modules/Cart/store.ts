import { makeAutoObservable } from 'mobx'
import { CartData, OrderData, OrderItemData, Step } from './models'

export class CartStore {
  order?: OrderData = undefined
  orderItems: OrderItemData[] = []
  reload = true
  step: Step = 'cart'

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
}
