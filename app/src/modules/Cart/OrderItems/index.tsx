import { FC } from "react";
import { observer } from "mobx-react-lite";

import { useCartContext } from "../context";

export const OrderItems: FC = observer(() => {
  const { order, order_items } = useCartContext()

  return (
    <div>
      {order_items?.map(order_item =>
        <div key={order_item.id}>
          <div>
            Image
          </div>
          <div>
            <div>
              {order_item.variant.title}
            </div>
          </div>
        </div>
      )}
    </div>
  )
})
