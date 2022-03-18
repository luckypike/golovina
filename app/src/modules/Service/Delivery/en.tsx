import { FC } from 'react'

import VisaMcImg from './visa-mc.svg'

export const DeliveryEn: FC = () => {
  return (
    <>
      <p>
        You can pay for the order in the shopbag or on the page of your orders using the &quot;Place Order&quot; button.
        The authorization page contains the card number, cardholder&apos;s name, card expiration date, card verification
        number (CVV2 for VISA or CVC2 for MasterCard). Payment is complete within a few minutes.
      </p>

      <VisaMcImg width={125} height={40} />

      <p>After payment, we confirm the details of the order.</p>

      <p>
        Attention: the seller is not responsible for non-fulfillment or delay of the order due to the inaccurate
        information. If the delivery company did not deliver the parcel through their own fault, the seller pays buyer
        for the item and the shipping cost.
      </p>

      <p>
        <strong>International Delivery</strong>
        <br />
        Shipping cost – 2800 RUB (delivery company EMS).
        <br />
        Delivery period – from 7 to 12 days (depending on the region).
      </p>
    </>
  )
}
